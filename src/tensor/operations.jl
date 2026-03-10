const ModeType = AbstractVector{<:Union{Char, Integer}}

# remove the HIPTENSOR_ prefix from some common enums,
# as they're namespaced to the cuTENSOR module anyway.
@enum_without_prefix hiptensorOperator_t HIPTENSOR_
@enum_without_prefix hiptensorWorksizePreference_t HIPTENSOR_
@enum_without_prefix hiptensorAlgo_t HIPTENSOR_
@enum_without_prefix hiptensorJitMode_t HIPTENSOR_

is_unary(op::hiptensorOperator_t) =  (op ∈ (OP_IDENTITY, OP_SQRT, OP_RELU, OP_CONJ, OP_RCP))
is_binary(op::hiptensorOperator_t) = (op ∈ (OP_ADD, OP_MUL, OP_MAX, OP_MIN))

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
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing,
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
    scalar_type = plan.scalar_type
    hiptensorElementwiseTrinaryExecute(handle(), plan,
                                      Ref{scalar_type}(alpha), A,
                                      Ref{scalar_type}(beta), B,
                                      Ref{scalar_type}(gamma), C, D,
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
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opB)    && throw(ArgumentError("opB must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opAB)  && throw(ArgumentError("opAB must be a binary op!"))
    !is_binary(opABC) && throw(ArgumentError("opABC must be a binary op!"))
    descA = hipTensorDescriptor(A)
    descB = hipTensorDescriptor(B)
    descC = hipTensorDescriptor(C)
    @assert size(C) == size(D) && strides(C) == strides(D)
    descD = descC # must currently be identical
    modeA = collect(Cint, Ainds)
    modeB = collect(Cint, Binds)
    modeC = collect(Cint, Cinds)
    modeD = modeC

    actual_compute_type = if compute_type === nothing
        elementwise_trinary_compute_types[(eltype(A), eltype(B), eltype(C))]
    else
        compute_type
    end

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateElementwiseTrinary(handle(),
                                     desc,
                                     descA, modeA, opA,
                                     descB, modeB, opB,
                                     descC, modeC, opC,
                                     descD, modeD,
                                     opAB, opABC,
                                     actual_compute_type)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    plan = hipTensorPlan(desc[], plan_pref[]; workspacePref=workspace)
    hiptensorDestroyOperationDescriptor(desc[])
    hiptensorDestroyPlanPreference(plan_pref[])
    return plan
end

function elementwise_binary_execute!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(gamma::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        @nospecialize(D::AbstractArray), Dinds::ModeType, opAC::hiptensorOperator_t;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing,
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
    scalar_type = plan.scalar_type
    hiptensorElementwiseBinaryExecute(handle(), plan,
                                      Ref{scalar_type}(alpha), A,
                                      Ref{scalar_type}(gamma), C, D,
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
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=eltype(C))
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opAC)  && throw(ArgumentError("opAC must be a binary op!"))
    descA = hipTensorDescriptor(A)
    descC = hipTensorDescriptor(C)
    @assert size(C) == size(D) && strides(C) == strides(D)
    descD = descC # must currently be identical
    modeA = collect(Cint, Ainds)
    modeC = collect(Cint, Cinds)
    modeD = modeC

    actual_compute_type = if compute_type === nothing
        elementwise_binary_compute_types[(eltype(A), eltype(C))]
    else
        compute_type
    end

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateElementwiseBinary(handle(),
                                     desc,
                                     descA, modeA, opA,
                                     descC, modeC, opC,
                                     descD, modeD,
                                     opAC,
                                     actual_compute_type)
    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    plan = hipTensorPlan(desc[], plan_pref[]; workspacePref=workspace, compute_type = actual_compute_type)
    hiptensorDestroyOperationDescriptor(desc[])
    hiptensorDestroyPlanPreference(plan_pref[])
    return plan
end

function permute!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing,
        plan::Union{hipTensorPlan, Nothing}=nothing)
    actual_plan = if plan === nothing
        plan_permutation(A, Ainds, opA,
                         B, Binds;
                         workspace, algo, compute_type)
    else
        plan
    end
    @show plan
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
    scalar_type = plan.scalar_type
    hiptensorPermute(handle(), plan,
                    Ref{scalar_type}(alpha), A, B,
                    stream().stream)
    return B
end

function plan_permutation(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(B::AbstractArray), Binds::ModeType;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing)
    descA = hipTensorDescriptor(A)
    descB = hipTensorDescriptor(B)

    modeA = collect(Cint, Ainds)
    modeB = collect(Cint, Binds)

    actual_compute_type = if compute_type === nothing
        permutation_compute_types[(eltype(A), eltype(B))]
    else
        compute_type
    end
    compute_desc = Base.cconvert(hiptensorComputeDescriptor_t, actual_compute_type)
    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreatePermutation(handle(), desc,
                              descA, modeA, opA,
                              descB, modeB,
                              compute_desc)
    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    plan = hipTensorPlan(desc[], plan_pref[]; workspacePref=workspace, compute_type = actual_compute_type)
    hiptensorDestroyOperationDescriptor(desc[])
    hiptensorDestroyPlanPreference(plan_pref[])
    return plan
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
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing,
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
    scalar_type = plan.scalar_type
    hiptensorContract(handle(), plan,
                     Ref{scalar_type}(alpha), A, B,
                     Ref{scalar_type}(beta), C, C,
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
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing)
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

    actual_compute_type = if compute_type === nothing
        contraction_compute_types[(eltype(A), eltype(B), eltype(C))]
    else
        compute_type
    end

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateContraction(handle(),
                              desc,
                              descA, modeA, opA,
                              descB, modeB, opB,
                              descC, modeC, opC,
                              descC, modeC,
                              actual_compute_type)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    plan = hipTensorPlan(desc[], plan_pref[]; workspacePref=workspace, compute_type = actual_compute_type)
    hiptensorDestroyOperationDescriptor(desc[])
    hiptensorDestroyPlanPreference(plan_pref[])
    return plan
end

function reduce!(
        @nospecialize(alpha::Number),
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(beta::Number),
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opReduce::hiptensorOperator_t;
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing,
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
    scalar_type = plan.scalar_type
    hiptensorReduce(handle(), plan,
                   Ref{scalar_type}(alpha), A,
                   Ref{scalar_type}(beta), C, C,
                   plan.workspace, sizeof(plan.workspace), Cint(0))
    return C
end

function plan_reduction(
        @nospecialize(A::AbstractArray), Ainds::ModeType, opA::hiptensorOperator_t,
        @nospecialize(C::AbstractArray), Cinds::ModeType, opC::hiptensorOperator_t,
        opReduce::hiptensorOperator_t;
        jit::hiptensorJitMode_t=JIT_MODE_NONE,
        workspace::hiptensorWorksizePreference_t=WORKSPACE_DEFAULT,
        algo::hiptensorAlgo_t=ALGO_DEFAULT,
        compute_type::Union{DataType, hiptensorComputeDescriptorEnum, Nothing}=nothing)
    !is_unary(opA)    && throw(ArgumentError("opA must be a unary op!"))
    !is_unary(opC)    && throw(ArgumentError("opC must be a unary op!"))
    !is_binary(opReduce)  && throw(ArgumentError("opReduce must be a binary op!"))
    descA = hipTensorDescriptor(A)
    descC = hipTensorDescriptor(C)
    # for now, D must be identical to C (and thus, descD must be identical to descC)
    modeA = collect(Cint, Ainds)
    modeC = collect(Cint, Cinds)

    actual_compute_type = if compute_type === nothing
        reduction_compute_types[(eltype(A), eltype(C))]
    else
        compute_type
    end

    desc = Ref{hiptensorOperationDescriptor_t}()
    hiptensorCreateReduction(handle(),
                            desc,
                            descA, modeA, opA,
                            descC, modeC, opC,
                            descC, modeC, opReduce,
                            actual_compute_type)

    plan_pref = Ref{hiptensorPlanPreference_t}()
    hiptensorCreatePlanPreference(handle(), plan_pref, algo, jit)

    plan = hipTensorPlan(desc[], plan_pref[]; workspacePref=workspace)
    hiptensorDestroyOperationDescriptor(desc[])
    hiptensorDestroyPlanPreference(plan_pref[])
    return plan
end
