const ModeType = AbstractVector{<:Union{Char, Integer}}

# remove the HIPTENSOR_ prefix from some common enums,
# as they're namespaced to the hipTENSOR module anyway.
@enum_without_prefix hiptensorOperator_t HIPTENSOR_
@enum_without_prefix hiptensorWorksizePreference_t HIPTENSOR_
@enum_without_prefix hiptensorAlgo_t HIPTENSOR_
@enum_without_prefix hiptensorJitMode_t HIPTENSOR_

is_unary(op::hiptensorOperator_t) =  (op ∈ (OP_IDENTITY, OP_SQRT, OP_RELU, OP_CONJ, OP_RCP))
is_binary(op::hiptensorOperator_t) = (op ∈ (OP_ADD, OP_MUL, OP_MAX, OP_MIN))

# The elementwise and reduction kernels in hipTENSOR 2.2 do not actually look at the mode
# labels to work out how the operands line up: they walk every tensor in the order its
# modes were declared, and silently produce garbage as soon as those orders differ. Only
# the contraction kernels handle arbitrary mode orders.
#
# We can hide that limitation without copying any data: describing `X` in the mode order
# `order` is just a matter of permuting the lengths and strides in its descriptor, after
# which every operand is declared in the same order and the kernels line up again.
# `order` must list the modes of `X` (in the case of a reduction, the modes of the output
# come first and the reduced modes follow).
function reordered_descriptor(@nospecialize(X::AbstractArray), Xinds::ModeType, order::ModeType)
    length(Xinds) == ndims(X) ||
        throw(ArgumentError("$(length(Xinds)) modes given for a $(ndims(X))-dimensional tensor"))
    perm = map(order) do mode
        i = findfirst(isequal(mode), Xinds)
        i === nothing && throw(ArgumentError("mode $mode is not one of the modes $Xinds"))
        i
    end
    return hipTensorDescriptor(collect(Int64, size(X))[perm],
                               collect(Int64, strides(X))[perm], eltype(X))
end

# the mode order every operand of an elementwise or reduction operation is declared in:
# the output's modes first (so that its layout is untouched), then the modes that only
# occur in the inputs, i.e. the ones a reduction sums over
function common_mode_order(Cinds::ModeType, Ainds::ModeType...)
    order = collect(Cinds)
    for inds in Ainds, mode in inds
        mode in order || push!(order, mode)
    end
    return order
end

function elementwise_trinary_execute!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(beta::Number),
        @nospecialize(B::AbstractArray), Binds::ModeType, opB::hiptensorOperator_t,
        @nospecialize(gamma::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        @nospecialize(D::AbstractArray), Dinds::ModeType, opAB::hiptensorOperator_t,
        opABC::hiptensorOperator_t;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)

    actual_plan = if plan === nothing
        plan_elementwise_trinary(A, Ainds, opA,
                                 B, Binds, opB,
                                 C, Cinds, opC,
                                 D, Dinds, opAB, opABC;
                                 workspace, algo, compute_type)
    else
        plan
    end

    elementwise_trinary_execute!(actual_plan, alpha, A, beta, B, gamma, C, D)

    if plan === nothing
        AMDGPU.unsafe_free!(actual_plan)
    end

    return D
end

function elementwise_trinary_execute!(plan::hipTensorPlan,
                                      @nospecialize(alpha::Number),
                                      @nospecialize(A::AbstractArray),
                                      @nospecialize(beta::Number),
                                      @nospecialize(B::AbstractArray),
                                      @nospecialize(gamma::Number),
                                      @nospecialize(C::AbstractArray),
                                      @nospecialize(D::AbstractArray))
    T = plan.scalar_type
    hiptensorElementwiseTrinaryExecute(handle(), plan,
                                      Ref{T}(alpha), A,
                                      Ref{T}(beta), B,
                                      Ref{T}(gamma), C, D,
                                      stream().stream)
    return D
end

function plan_elementwise_trinary(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType, opB::hiptensorOperator_t,
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        @nospecialize(D::AbstractArray), Dinds::ModeType, opAB::hiptensorOperator_t,
        opABC::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opB)    && throw(ArgumentError("opB must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opAB)  && throw(ArgumentError("opAB must be a binary op!"))
    !is_binary(opABC) && throw(ArgumentError("opABC must be a binary op!"))
    @assert size(C) == size(D) && strides(C) == strides(D)
    # every operand is declared in the output's mode order, see `reordered_descriptor`
    order = common_mode_order(Cinds)
    descA = reordered_descriptor(A, Ainds, order)
    descB = reordered_descriptor(B, Binds, order)
    descC = reordered_descriptor(C, Cinds, order)
    descD = descC # must currently be identical
    mode = collect(Cint, order)

    compute_desc = compute_descriptor(compute_type === nothing ?
        default_compute_type(elementwise_trinary_compute_types, "elementwise trinary operation",
                             (eltype(A), eltype(B), eltype(C))) : compute_type)

    desc = Ref{hiptensorOperationDescriptor_t}()
    # hipTENSOR 2.2 has the two binary operators the wrong way round: it applies the
    # operator passed as `opABC` to A and B, and the one passed as `opAB` to that
    # intermediate result and C. Swap them here so that this wrapper computes the
    # documented D = opABC(opAB(αA, βB), γC).
    hiptensorCreateElementwiseTrinary(handle(),
                                     desc,
                                     descA, mode, opA,
                                     descB, mode, opB,
                                     descC, mode, opC,
                                     descD, mode,
                                     opABC, opAB,
                                     compute_desc)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    scalar = scalar_type(compute_desc, eltype(A), eltype(B), eltype(C), eltype(D))
    return hipTensorPlan(desc[], plan_pref[], scalar, Any[descA, descB, descC, mode];
                         workspacePref=workspace)
end

function elementwise_binary_execute!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(gamma::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        @nospecialize(D::AbstractArray), Dinds::ModeType, opAC::hiptensorOperator_t;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)
    actual_plan = if plan === nothing
        plan_elementwise_binary(A, Ainds, opA,
                                C, Cinds, opC,
                                D, Dinds, opAC;
                                workspace, algo, compute_type)
    else
        plan
    end
    elementwise_binary_execute!(actual_plan, alpha, A, gamma, C, D)
    if plan === nothing
        AMDGPU.unsafe_free!(actual_plan)
    end

    return D
end

function elementwise_binary_execute!(plan::hipTensorPlan,
                                     @nospecialize(alpha::Number),
                                     @nospecialize(A::AbstractArray),
                                     @nospecialize(gamma::Number),
                                     @nospecialize(C::AbstractArray),
                                     @nospecialize(D::AbstractArray))
    T = plan.scalar_type
    hiptensorElementwiseBinaryExecute(handle(), plan,
                                      Ref{T}(alpha), A,
                                      Ref{T}(gamma), C, D,
                                      stream().stream)
    return D
end

function plan_elementwise_binary(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        @nospecialize(D::AbstractArray), Dinds::ModeType, opAC::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opAC)  && throw(ArgumentError("opAC must be a binary op!"))
    @assert size(C) == size(D) && strides(C) == strides(D)
    # every operand is declared in the output's mode order, see `reordered_descriptor`
    order = common_mode_order(Cinds)
    descA = reordered_descriptor(A, Ainds, order)
    descC = reordered_descriptor(C, Cinds, order)
    descD = descC # must currently be identical
    mode = collect(Cint, order)

    compute_desc = compute_descriptor(compute_type === nothing ?
        default_compute_type(elementwise_binary_compute_types, "elementwise binary operation",
                             (eltype(A), eltype(C))) : compute_type)

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateElementwiseBinary(handle(),
                                     desc,
                                     descA, mode, opA,
                                     descC, mode, opC,
                                     descD, mode,
                                     opAC,
                                     compute_desc)
    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    scalar = scalar_type(compute_desc, eltype(A), eltype(C), eltype(D))
    return hipTensorPlan(desc[], plan_pref[], scalar, Any[descA, descC, mode];
                         workspacePref=workspace)
end

function permute!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)
    actual_plan = if plan === nothing
        plan_permutation(A, Ainds, opA,
                         B, Binds;
                         workspace, algo, compute_type)
    else
        plan
    end
    permute!(actual_plan, alpha, A, B)

    if plan === nothing
        AMDGPU.unsafe_free!(actual_plan)
    end

    return B
end

function permute!(plan::hipTensorPlan,
                  @nospecialize(alpha::Number),
                  @nospecialize(A::AbstractArray),
                  @nospecialize(B::AbstractArray))
    T = plan.scalar_type
    hiptensorPermute(handle(), plan,
                    Ref{T}(alpha), A, B,
                    stream().stream)
    return B
end

function plan_permutation(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing)
    descA = hipTensorDescriptor(A)
    descB = hipTensorDescriptor(B)

    modeA = collect(Cint, Ainds)
    modeB = collect(Cint, Binds)

    compute_desc = compute_descriptor(compute_type === nothing ?
        default_compute_type(permutation_compute_types, "permutation",
                             (eltype(A), eltype(B))) : compute_type)

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreatePermutation(handle(), desc,
                              descA, modeA, opA,
                              descB, modeB,
                              compute_desc)
    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    scalar = scalar_type(compute_desc, eltype(A), eltype(B))
    return hipTensorPlan(desc[], plan_pref[], scalar,
                         Any[descA, descB, modeA, modeB];
                         workspacePref=workspace)
end

function contract!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType, opB::hiptensorOperator_t,
        @nospecialize(beta::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opOut::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)
    actual_plan = if plan === nothing
        plan_contraction(A, Ainds, opA, B, Binds, opB, C, Cinds, opC, opOut;
                         jit, workspace, algo, compute_type)
    else
        plan
    end

    contract!(actual_plan, alpha, A, B, beta, C)

    if plan === nothing
        AMDGPU.unsafe_free!(actual_plan)
    end

    return C
end

function contract!(plan::hipTensorPlan,
                   @nospecialize(alpha::Number),
                   @nospecialize(A::AbstractArray),
                   @nospecialize(B::AbstractArray),
                   @nospecialize(beta::Number),
                   @nospecialize(C::AbstractArray))
    T = plan.scalar_type
    hiptensorContract(handle(), plan,
                     Ref{T}(alpha), A, B,
                     Ref{T}(beta), C, C,
                     plan.workspace, sizeof(plan.workspace), stream().stream)
    return C
end

function plan_contraction(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType, opB::hiptensorOperator_t,
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opOut::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opB)    && throw(ArgumentError("opB must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_unary(opOut)  && throw(ArgumentError("opOut must be a unary op!"))
    descA = hipTensorDescriptor(A)
    descB = hipTensorDescriptor(B)
    descC = hipTensorDescriptor(C)
    # for now, D must be identical to C (and thus, descD must be identical to descC)
    modeA = collect(Cint, Ainds)
    length(modeA) == ndims(A) || throw(ArgumentError("Ainds must match number of dimensions in A!"))
    modeB = collect(Cint, Binds)
    length(modeB) == ndims(B) || throw(ArgumentError("Binds must match number of dimensions in B!"))
    modeC = collect(Cint, Cinds)
    length(modeC) == ndims(C) || throw(ArgumentError("Cinds must match number of dimensions in C!"))

    compute_desc = compute_descriptor(compute_type === nothing ?
        default_compute_type(contraction_compute_types, "contraction",
                             (eltype(A), eltype(B), eltype(C))) : compute_type)

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateContraction(handle(),
                              desc,
                              descA, modeA, opA,
                              descB, modeB, opB,
                              descC, modeC, opC,
                              descC, modeC,
                              compute_desc)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    scalar = scalar_type(compute_desc, eltype(A), eltype(B), eltype(C))
    return hipTensorPlan(desc[], plan_pref[], scalar,
                         Any[descA, descB, descC, modeA, modeB, modeC];
                         workspacePref=workspace)
end

function reduce!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(beta::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opReduce::hiptensorOperator_t;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)
    actual_plan = if plan === nothing
        plan_reduction(A, Ainds, opA, C, Cinds, opC, opReduce; workspace, algo, compute_type)
    else
        plan
    end

    reduce!(actual_plan, alpha, A, beta, C)

    if plan === nothing
        AMDGPU.unsafe_free!(actual_plan)
    end

    return C
end

function reduce!(plan::hipTensorPlan,
                 @nospecialize(alpha::Number),
                 @nospecialize(A::AbstractArray),
                 @nospecialize(beta::Number),
                 @nospecialize(C::AbstractArray))
    T = plan.scalar_type
    hiptensorReduce(handle(), plan,
                   Ref{T}(alpha), A,
                   Ref{T}(beta), C, C,
                   plan.workspace, sizeof(plan.workspace), stream().stream)
    return C
end

function plan_reduction(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opReduce::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptor_t, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opReduce)  && throw(ArgumentError("opReduce must be a binary op!"))
    # A is declared with the output's modes first and the reduced modes last, so that its
    # mode order agrees with C's, see `reordered_descriptor`
    order = common_mode_order(Cinds, Ainds)
    descA = reordered_descriptor(A, Ainds, order)
    descC = reordered_descriptor(C, Cinds, Cinds)
    # for now, D must be identical to C (and thus, descD must be identical to descC)
    modeA = collect(Cint, order)
    modeC = collect(Cint, Cinds)

    compute_desc = compute_descriptor(compute_type === nothing ?
        default_compute_type(reduction_compute_types, "reduction",
                             (eltype(A), eltype(C))) : compute_type)

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateReduction(handle(),
                            desc,
                            descA, modeA, opA,
                            descC, modeC, opC,
                            descC, modeC, opReduce,
                            compute_desc)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    scalar = scalar_type(compute_desc, eltype(A), eltype(C))
    return hipTensorPlan(desc[], plan_pref[], scalar,
                         Any[descA, descC, modeA, modeC];
                         workspacePref=workspace)
end
