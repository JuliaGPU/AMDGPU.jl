@inline function retry_reclaim(f, retry_if)
  ret = f()
  if retry_if(ret)
    return alloc_or_retry!(f, retry_if)
  else
    return ret
  end
end

@cenum hiptensorStatus_t::UInt32 begin
    HIPTENSOR_STATUS_SUCCESS = 0
    HIPTENSOR_STATUS_NOT_INITIALIZED = 1
    HIPTENSOR_STATUS_ALLOC_FAILED = 3
    HIPTENSOR_STATUS_INVALID_VALUE = 7
    HIPTENSOR_STATUS_ARCH_MISMATCH = 8
    HIPTENSOR_STATUS_EXECUTION_FAILED = 13
    HIPTENSOR_STATUS_INTERNAL_ERROR = 14
    HIPTENSOR_STATUS_NOT_SUPPORTED = 15
    HIPTENSOR_STATUS_CK_ERROR = 17
    HIPTENSOR_STATUS_HIP_ERROR = 18
    HIPTENSOR_STATUS_INSUFFICIENT_WORKSPACE = 19
    HIPTENSOR_STATUS_INSUFFICIENT_DRIVER = 20
    HIPTENSOR_STATUS_IO_ERROR = 21
end

# outlined functionality to avoid GC frame allocation
@noinline function throw_api_error(res)
    if res == HIPTENSOR_STATUS_ALLOC_FAILED
        throw(OutOfGPUMemoryError())
    else
        throw(hipTENSORError(res))
    end
end

@inline function check(f)
    retry_if(res) = res in (HIPTENSOR_STATUS_NOT_INITIALIZED,
                            HIPTENSOR_STATUS_ALLOC_FAILED,
                            HIPTENSOR_STATUS_INTERNAL_ERROR)
    res = retry_reclaim(f, retry_if)

    if res != HIPTENSOR_STATUS_SUCCESS
        throw_api_error(res)
    end
end

function hiptensorGetErrorString(error)
    @ccall libhiptensor.hiptensorGetErrorString(error::hiptensorStatus_t)::Ptr{Cchar}
end

mutable struct hiptensorHandle end

const hiptensorHandle_t = Ptr{hiptensorHandle}

@checked function hiptensorCreate(handle)
    AMDGPU.prepare_state()
    @gcsafe_ccall libhiptensor.hiptensorCreate(handle::Ptr{hiptensorHandle_t})::hiptensorStatus_t
end

@checked function hiptensorDestroy(handle)
    @gcsafe_ccall libhiptensor.hiptensorDestroy(handle::hiptensorHandle_t)::hiptensorStatus_t
end

@checked function hiptensorHandleResizePlanCache(handle, numEntries)
    @ccall libhiptensor.hiptensorHandleResizePlanCache(handle::hiptensorHandle_t,
                                                       numEntries::UInt32)::hiptensorStatus_t
end

@checked function hiptensorHandleWritePlanCacheToFile(handle, fileName)
    @ccall libhiptensor.hiptensorHandleWritePlanCacheToFile(handle::hiptensorHandle_t,
                                                            fileName::Ptr{Cchar})::hiptensorStatus_t
end

@checked function hiptensorHandleReadPlanCacheFromFile(handle, fileName, numCachelinesRead)
    @ccall libhiptensor.hiptensorHandleReadPlanCacheFromFile(handle::hiptensorHandle_t,
                                                             fileName::Ptr{Cchar},
                                                             numCachelinesRead::Ptr{UInt32})::hiptensorStatus_t
end

@checked function hiptensorWriteKernelCacheToFile(handle, fileName)
    @ccall libhiptensor.hiptensorWriteKernelCacheToFile(handle::hiptensorHandle_t,
                                                        fileName::Ptr{Cchar})::hiptensorStatus_t
end

@checked function hiptensorReadKernelCacheFromFile(handle, fileName)
    @ccall libhiptensor.hiptensorReadKernelCacheFromFile(handle::hiptensorHandle_t,
                                                         fileName::Ptr{Cchar})::hiptensorStatus_t
end

mutable struct hiptensorTensorDescriptor end

const hiptensorTensorDescriptor_t = Ptr{hiptensorTensorDescriptor}

@cenum hiptensorDataType_t::UInt32 begin
    HIPTENSOR_R_32F = 0
    HIPTENSOR_R_64F = 1
    HIPTENSOR_R_16F = 2
    HIPTENSOR_R_8I = 3
    HIPTENSOR_C_32F = 4
    HIPTENSOR_C_64F = 5
    HIPTENSOR_C_16F = 6
    HIPTENSOR_C_8I = 7
    HIPTENSOR_R_8U = 8
    HIPTENSOR_C_8U = 9
    HIPTENSOR_R_32I = 10
    HIPTENSOR_C_32I = 11
    HIPTENSOR_R_32U = 12
    HIPTENSOR_C_32U = 13
    HIPTENSOR_R_16BF = 14
    HIPTENSOR_C_16BF = 15
    HIPTENSOR_R_4I = 16
    HIPTENSOR_C_4I = 17
    HIPTENSOR_R_4U = 18
    HIPTENSOR_C_4U = 19
    HIPTENSOR_R_16I = 20
    HIPTENSOR_C_16I = 21
    HIPTENSOR_R_16U = 22
    HIPTENSOR_C_16U = 23
    HIPTENSOR_R_64I = 24
    HIPTENSOR_C_64I = 25
    HIPTENSOR_R_64U = 26
    HIPTENSOR_C_64U = 27
end

@checked function hiptensorCreateTensorDescriptor(handle, desc, numModes, lens, strides, dataType,
                                         alignmentRequirement)
    @ccall libhiptensor.hiptensorCreateTensorDescriptor(handle::hiptensorHandle_t,
                                                        desc::Ptr{hiptensorTensorDescriptor_t},
                                                        numModes::UInt32, lens::Ptr{Int64},
                                                        strides::Ptr{Int64},
                                                        dataType::hiptensorDataType_t,
                                                        alignmentRequirement::UInt32)::hiptensorStatus_t
end

@checked function hiptensorDestroyTensorDescriptor(desc)
    @ccall libhiptensor.hiptensorDestroyTensorDescriptor(desc::hiptensorTensorDescriptor_t)::hiptensorStatus_t
end

mutable struct hiptensorOperationDescriptor end

const hiptensorOperationDescriptor_t = Ptr{hiptensorOperationDescriptor}

@cenum hiptensorOperator_t::UInt32 begin
    HIPTENSOR_OP_IDENTITY = 1
    HIPTENSOR_OP_SQRT = 2
    HIPTENSOR_OP_RELU = 8
    HIPTENSOR_OP_CONJ = 9
    HIPTENSOR_OP_RCP = 10
    HIPTENSOR_OP_SIGMOID = 11
    HIPTENSOR_OP_TANH = 12
    HIPTENSOR_OP_EXP = 22
    HIPTENSOR_OP_LOG = 23
    HIPTENSOR_OP_ABS = 24
    HIPTENSOR_OP_NEG = 25
    HIPTENSOR_OP_SIN = 26
    HIPTENSOR_OP_COS = 27
    HIPTENSOR_OP_TAN = 28
    HIPTENSOR_OP_SINH = 29
    HIPTENSOR_OP_COSH = 30
    HIPTENSOR_OP_ASIN = 31
    HIPTENSOR_OP_ACOS = 32
    HIPTENSOR_OP_ATAN = 33
    HIPTENSOR_OP_ASINH = 34
    HIPTENSOR_OP_ACOSH = 35
    HIPTENSOR_OP_ATANH = 36
    HIPTENSOR_OP_CEIL = 37
    HIPTENSOR_OP_FLOOR = 38
    HIPTENSOR_OP_ADD = 3
    HIPTENSOR_OP_MUL = 5
    HIPTENSOR_OP_MAX = 6
    HIPTENSOR_OP_MIN = 7
    HIPTENSOR_OP_UNKNOWN = 126
end

@cenum hiptensorComputeDescriptor_t::UInt32 begin
    HIPTENSOR_COMPUTE_DESC_32F = 4
    HIPTENSOR_COMPUTE_DESC_64F = 16
    HIPTENSOR_COMPUTE_DESC_16F = 1
    HIPTENSOR_COMPUTE_DESC_16BF = 1024
    HIPTENSOR_COMPUTE_DESC_C32F = 2048
    HIPTENSOR_COMPUTE_DESC_C64F = 4096
    HIPTENSOR_COMPUTE_DESC_NONE = 0
    HIPTENSOR_COMPUTE_DESC_8U = 64
    HIPTENSOR_COMPUTE_DESC_8I = 256
    HIPTENSOR_COMPUTE_DESC_32U = 128
    HIPTENSOR_COMPUTE_DESC_32I = 512
end

@checked function hiptensorCreateContraction(handle, desc, descA, modeA, opA, descB, modeB, opB,
                                    descC, modeC, opC, descD, modeD, descCompute)
    @ccall libhiptensor.hiptensorCreateContraction(handle::hiptensorHandle_t,
                                                   desc::Ptr{hiptensorOperationDescriptor_t},
                                                   descA::hiptensorTensorDescriptor_t,
                                                   modeA::Ptr{Int32},
                                                   opA::hiptensorOperator_t,
                                                   descB::hiptensorTensorDescriptor_t,
                                                   modeB::Ptr{Int32},
                                                   opB::hiptensorOperator_t,
                                                   descC::hiptensorTensorDescriptor_t,
                                                   modeC::Ptr{Int32},
                                                   opC::hiptensorOperator_t,
                                                   descD::hiptensorTensorDescriptor_t,
                                                   modeD::Ptr{Int32},
                                                   descCompute::hiptensorComputeDescriptor_t)::hiptensorStatus_t
end

@checked function hiptensorDestroyOperationDescriptor(desc)
    @ccall libhiptensor.hiptensorDestroyOperationDescriptor(desc::hiptensorOperationDescriptor_t)::hiptensorStatus_t
end

@cenum hiptensorOperationDescriptorAttribute_t::UInt32 begin
    HIPTENSOR_OPERATION_DESCRIPTOR_TAG = 0
    HIPTENSOR_OPERATION_DESCRIPTOR_SCALAR_TYPE = 1
    HIPTENSOR_OPERATION_DESCRIPTOR_FLOPS = 2
    HIPTENSOR_OPERATION_DESCRIPTOR_MOVED_BYTES = 3
    HIPTENSOR_OPERATION_DESCRIPTOR_PADDING_LEFT = 4
    HIPTENSOR_OPERATION_DESCRIPTOR_PADDING_RIGHT = 5
    HIPTENSOR_OPERATION_DESCRIPTOR_PADDING_VALUE = 6
end

@checked function hiptensorOperationDescriptorSetAttribute(handle, desc, attr, buf, sizeInBytes)
    @ccall libhiptensor.hiptensorOperationDescriptorSetAttribute(handle::hiptensorHandle_t,
                                                                 desc::hiptensorOperationDescriptor_t,
                                                                 attr::hiptensorOperationDescriptorAttribute_t,
                                                                 buf::Ptr{Cvoid},
                                                                 sizeInBytes::Csize_t)::hiptensorStatus_t
end

@checked function hiptensorOperationDescriptorGetAttribute(handle, desc, attr, buf, sizeInBytes)
    @ccall libhiptensor.hiptensorOperationDescriptorGetAttribute(handle::hiptensorHandle_t,
                                                                 desc::hiptensorOperationDescriptor_t,
                                                                 attr::hiptensorOperationDescriptorAttribute_t,
                                                                 buf::Ptr{Cvoid},
                                                                 sizeInBytes::Csize_t)::hiptensorStatus_t
end

mutable struct hiptensorPlanPreference end

const hiptensorPlanPreference_t = Ptr{hiptensorPlanPreference}

@cenum hiptensorAlgo_t::Int32 begin
    HIPTENSOR_ALGO_ACTOR_CRITIC = -8
    HIPTENSOR_ALGO_DEFAULT = -1
    HIPTENSOR_ALGO_DEFAULT_PATIENT = -6
end

@cenum hiptensorJitMode_t::UInt32 begin
    HIPTENSOR_JIT_MODE_NONE = 0
    HIPTENSOR_JIT_MODE_DEFAULT = 1
end

@checked function hiptensorCreatePlanPreference(handle, pref, algo, jitMode)
    @ccall libhiptensor.hiptensorCreatePlanPreference(handle::hiptensorHandle_t,
                                                      pref::Ptr{hiptensorPlanPreference_t},
                                                      algo::hiptensorAlgo_t,
                                                      jitMode::hiptensorJitMode_t)::hiptensorStatus_t
end

@checked function hiptensorDestroyPlanPreference(pref)
    @ccall libhiptensor.hiptensorDestroyPlanPreference(pref::hiptensorPlanPreference_t)::hiptensorStatus_t
end

@cenum hiptensorPlanPreferenceAttribute_t::UInt32 begin
    HIPTENSOR_PLAN_PREFERENCE_AUTOTUNE_MODE = 0
    HIPTENSOR_PLAN_PREFERENCE_CACHE_MODE = 1
    HIPTENSOR_PLAN_PREFERENCE_INCREMENTAL_COUNT = 2
    HIPTENSOR_PLAN_PREFERENCE_ALGO = 3
    HIPTENSOR_PLAN_PREFERENCE_KERNEL_RANK = 4
    HIPTENSOR_PLAN_PREFERENCE_JIT = 5
end

@checked function hiptensorPlanPreferenceSetAttribute(handle, pref, attr, buf, sizeInBytes)
    @ccall libhiptensor.hiptensorPlanPreferenceSetAttribute(handle::hiptensorHandle_t,
                                                            pref::hiptensorPlanPreference_t,
                                                            attr::hiptensorPlanPreferenceAttribute_t,
                                                            buf::Ptr{Cvoid},
                                                            sizeInBytes::Csize_t)::hiptensorStatus_t
end

mutable struct hiptensorPlan end

const hiptensorPlan_t = Ptr{hiptensorPlan}

@cenum hiptensorPlanAttribute_t::UInt32 begin
    HIPTENSOR_PLAN_REQUIRED_WORKSPACE = 0
end

@checked function hiptensorPlanGetAttribute(handle, plan, attr, buf, sizeInBytes)
    @ccall libhiptensor.hiptensorPlanGetAttribute(handle::hiptensorHandle_t,
                                                  plan::hiptensorPlan_t,
                                                  attr::hiptensorPlanAttribute_t,
                                                  buf::Ptr{Cvoid},
                                                  sizeInBytes::Csize_t)::hiptensorStatus_t
end

@cenum hiptensorWorksizePreference_t::UInt32 begin
    HIPTENSOR_WORKSPACE_MIN = 1
    HIPTENSOR_WORKSPACE_DEFAULT = 2
    HIPTENSOR_WORKSPACE_MAX = 3
end

@checked function hiptensorEstimateWorkspaceSize(handle, desc, planPref, workspacePref,
                                        workspaceSizeEstimate)
    @ccall libhiptensor.hiptensorEstimateWorkspaceSize(handle::hiptensorHandle_t,
                                                       desc::hiptensorOperationDescriptor_t,
                                                       planPref::hiptensorPlanPreference_t,
                                                       workspacePref::hiptensorWorksizePreference_t,
                                                       workspaceSizeEstimate::Ptr{UInt64})::hiptensorStatus_t
end

@checked function hiptensorCreatePermutation(handle, desc, descA, modeA, opA, descB, modeB,
                                    descCompute)
    @ccall libhiptensor.hiptensorCreatePermutation(handle::hiptensorHandle_t,
                                                   desc::Ptr{hiptensorOperationDescriptor_t},
                                                   descA::hiptensorTensorDescriptor_t,
                                                   modeA::Ptr{Int32},
                                                   opA::hiptensorOperator_t,
                                                   descB::hiptensorTensorDescriptor_t,
                                                   modeB::Ptr{Int32},
                                                   descCompute::hiptensorComputeDescriptor_t)::hiptensorStatus_t
end

@checked function hiptensorCreatePlan(handle, plan, desc, pref, workspaceSizeLimit)
    @ccall libhiptensor.hiptensorCreatePlan(handle::hiptensorHandle_t,
                                            plan::Ptr{hiptensorPlan_t},
                                            desc::hiptensorOperationDescriptor_t,
                                            pref::hiptensorPlanPreference_t,
                                            workspaceSizeLimit::UInt64)::hiptensorStatus_t
end

@checked function hiptensorDestroyPlan(plan)
    @ccall libhiptensor.hiptensorDestroyPlan(plan::hiptensorPlan_t)::hiptensorStatus_t
end

@checked function hiptensorContract(handle, plan, alpha, A, B, beta, C, D, workspace, workspaceSize,
                           stream)
    @ccall libhiptensor.hiptensorContract(handle::hiptensorHandle_t, plan::hiptensorPlan_t,
                                          alpha::Ptr{Cvoid}, A::Ptr{Cvoid}, B::Ptr{Cvoid},
                                          beta::Ptr{Cvoid}, C::Ptr{Cvoid}, D::Ptr{Cvoid},
                                          workspace::Ptr{Cvoid}, workspaceSize::UInt64,
                                          stream::Cint)::hiptensorStatus_t
end

@checked function hiptensorPermute(handle, plan, alpha, A, B, stream)
    @ccall libhiptensor.hiptensorPermute(handle::hiptensorHandle_t, plan::hiptensorPlan_t,
                                         alpha::Ptr{Cvoid}, A::Ptr{Cvoid}, B::Ptr{Cvoid},
                                         stream::Cint)::hiptensorStatus_t
end

@checked function hiptensorCreateElementwiseBinary(handle, desc, descA, modeA, opA, descC, modeC,
                                          opC, descD, modeD, opAC, descCompute)
    @ccall libhiptensor.hiptensorCreateElementwiseBinary(handle::hiptensorHandle_t,
                                                         desc::Ptr{hiptensorOperationDescriptor_t},
                                                         descA::hiptensorTensorDescriptor_t,
                                                         modeA::Ptr{Int32},
                                                         opA::hiptensorOperator_t,
                                                         descC::hiptensorTensorDescriptor_t,
                                                         modeC::Ptr{Int32},
                                                         opC::hiptensorOperator_t,
                                                         descD::hiptensorTensorDescriptor_t,
                                                         modeD::Ptr{Int32},
                                                         opAC::hiptensorOperator_t,
                                                         descCompute::hiptensorComputeDescriptor_t)::hiptensorStatus_t
end

@checked function hiptensorElementwiseBinaryExecute(handle, plan, alpha, A, gamma, C, D, stream)
    @ccall libhiptensor.hiptensorElementwiseBinaryExecute(handle::hiptensorHandle_t,
                                                          plan::hiptensorPlan_t,
                                                          alpha::Ptr{Cvoid}, A::Ptr{Cvoid},
                                                          gamma::Ptr{Cvoid}, C::Ptr{Cvoid},
                                                          D::Ptr{Cvoid},
                                                          stream::Cint)::hiptensorStatus_t
end

@checked function hiptensorCreateElementwiseTrinary(handle, desc, descA, modeA, opA, descB, modeB,
                                           opB, descC, modeC, opC, descD, modeD, opAB,
                                           opABC, descCompute)
    @ccall libhiptensor.hiptensorCreateElementwiseTrinary(handle::hiptensorHandle_t,
                                                          desc::Ptr{hiptensorOperationDescriptor_t},
                                                          descA::hiptensorTensorDescriptor_t,
                                                          modeA::Ptr{Int32},
                                                          opA::hiptensorOperator_t,
                                                          descB::hiptensorTensorDescriptor_t,
                                                          modeB::Ptr{Int32},
                                                          opB::hiptensorOperator_t,
                                                          descC::hiptensorTensorDescriptor_t,
                                                          modeC::Ptr{Int32},
                                                          opC::hiptensorOperator_t,
                                                          descD::hiptensorTensorDescriptor_t,
                                                          modeD::Ptr{Int32},
                                                          opAB::hiptensorOperator_t,
                                                          opABC::hiptensorOperator_t,
                                                          descCompute::hiptensorComputeDescriptor_t)::hiptensorStatus_t
end

@checked function hiptensorElementwiseTrinaryExecute(handle, plan, alpha, A, beta, B, gamma, C, D,
                                            stream)
    @ccall libhiptensor.hiptensorElementwiseTrinaryExecute(handle::hiptensorHandle_t,
                                                           plan::hiptensorPlan_t,
                                                           alpha::Ptr{Cvoid}, A::Ptr{Cvoid},
                                                           beta::Ptr{Cvoid}, B::Ptr{Cvoid},
                                                           gamma::Ptr{Cvoid}, C::Ptr{Cvoid},
                                                           D::Ptr{Cvoid},
                                                           stream::Cint)::hiptensorStatus_t
end

@checked function hiptensorCreateReduction(handle, desc, descA, modeA, opA, descC, modeC, opC, descD,
                                  modeD, opReduce, descCompute)
    @ccall libhiptensor.hiptensorCreateReduction(handle::hiptensorHandle_t,
                                                 desc::Ptr{hiptensorOperationDescriptor_t},
                                                 descA::hiptensorTensorDescriptor_t,
                                                 modeA::Ptr{Int32},
                                                 opA::hiptensorOperator_t,
                                                 descC::hiptensorTensorDescriptor_t,
                                                 modeC::Ptr{Int32},
                                                 opC::hiptensorOperator_t,
                                                 descD::hiptensorTensorDescriptor_t,
                                                 modeD::Ptr{Int32},
                                                 opReduce::hiptensorOperator_t,
                                                 descCompute::hiptensorComputeDescriptor_t)::hiptensorStatus_t
end

@checked function hiptensorReduce(handle, plan, alpha, A, beta, C, D, workspace, workspaceSize,
                         stream)
    @ccall libhiptensor.hiptensorReduce(handle::hiptensorHandle_t, plan::hiptensorPlan_t,
                                        alpha::Ptr{Cvoid}, A::Ptr{Cvoid}, beta::Ptr{Cvoid},
                                        C::Ptr{Cvoid}, D::Ptr{Cvoid}, workspace::Ptr{Cvoid},
                                        workspaceSize::UInt64,
                                        stream::Cint)::hiptensorStatus_t
end

# typedef void ( * hiptensorLoggerCallback_t ) ( int32_t logContext , const char * funcName , const char * msg )
const hiptensorLoggerCallback_t = Ptr{Cvoid}

function hiptensorLoggerSetCallback(callback)
    @ccall libhiptensor.hiptensorLoggerSetCallback(callback::hiptensorLoggerCallback_t)::hiptensorStatus_t
end

function hiptensorLoggerSetFile(file)
    @ccall libhiptensor.hiptensorLoggerSetFile(file::Ptr{Libc.FILE})::hiptensorStatus_t
end

function hiptensorLoggerOpenFile(logFile)
    @ccall libhiptensor.hiptensorLoggerOpenFile(logFile::Ptr{Cchar})::hiptensorStatus_t
end

@cenum hiptensorLogLevel_t::UInt32 begin
    HIPTENSOR_LOG_LEVEL_OFF = 0
    HIPTENSOR_LOG_LEVEL_ERROR = 1
    HIPTENSOR_LOG_LEVEL_PERF_TRACE = 2
    HIPTENSOR_LOG_LEVEL_PERF_HINT = 4
    HIPTENSOR_LOG_LEVEL_HEURISTICS_TRACE = 8
    HIPTENSOR_LOG_LEVEL_API_TRACE = 16
end

function hiptensorLoggerSetLevel(level)
    @ccall libhiptensor.hiptensorLoggerSetLevel(level::hiptensorLogLevel_t)::hiptensorStatus_t
end

function hiptensorLoggerSetMask(mask)
    @ccall libhiptensor.hiptensorLoggerSetMask(mask::Int32)::hiptensorStatus_t
end

# no prototype is found for this function at hiptensor.h:578:19, please use with caution
function hiptensorLoggerForceDisable()
    @ccall libhiptensor.hiptensorLoggerForceDisable()::hiptensorStatus_t
end

# no prototype is found for this function at hiptensor.h:583:5, please use with caution
function hiptensorGetHiprtVersion()
    @ccall libhiptensor.hiptensorGetHiprtVersion()::Cint
end

# no prototype is found for this function at hiptensor.h:589:8, please use with caution
function hiptensorGetVersion()
    @ccall libhiptensor.hiptensorGetVersion()::Csize_t
end

@cenum hiptensorAutotuneMode_t::UInt32 begin
    HIPTENSOR_AUTOTUNE_MODE_NONE = 0
    HIPTENSOR_AUTOTUNE_MODE_INCREMENTAL = 1
end

@cenum hiptensorCacheMode_t::UInt32 begin
    HIPTENSOR_CACHE_MODE_NONE = 0
    HIPTENSOR_CACHE_MODE_PEDANTIC = 1
end

# Skipping MacroDefinition: HIP_PUBLIC_API __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: HIP_INTERNAL_EXPORTED_API __attribute__ ( ( visibility ( "default" ) ) )

const __HIP_ARCH_HAS_GLOBAL_INT32_ATOMICS__ = 0

const __HIP_ARCH_HAS_GLOBAL_FLOAT_ATOMIC_EXCH__ = 0

const __HIP_ARCH_HAS_SHARED_INT32_ATOMICS__ = 0

const __HIP_ARCH_HAS_SHARED_FLOAT_ATOMIC_EXCH__ = 0

const __HIP_ARCH_HAS_FLOAT_ATOMIC_ADD__ = 0

const __HIP_ARCH_HAS_GLOBAL_INT64_ATOMICS__ = 0

const __HIP_ARCH_HAS_SHARED_INT64_ATOMICS__ = 0

const __HIP_ARCH_HAS_DOUBLES__ = 0

const __HIP_ARCH_HAS_WARP_VOTE__ = 0

const __HIP_ARCH_HAS_WARP_BALLOT__ = 0

const __HIP_ARCH_HAS_WARP_SHUFFLE__ = 0

const __HIP_ARCH_HAS_WARP_FUNNEL_SHIFT__ = 0

const __HIP_ARCH_HAS_THREAD_FENCE_SYSTEM__ = 0

const __HIP_ARCH_HAS_SYNC_THREAD_EXT__ = 0

const __HIP_ARCH_HAS_SURFACE_FUNCS__ = 0

const __HIP_ARCH_HAS_3DGRID__ = 0

const __HIP_ARCH_HAS_DYNAMIC_PARALLEL__ = 0

const HIPTENSOR_MAJOR_VERSION = 2

const HIPTENSOR_MINOR_VERSION = 2

const HIPTENSOR_PATCH_VERSION = 0

const HIP_VERSION_MAJOR = 7

const HIP_VERSION_MINOR = 2

const HIP_VERSION_PATCH = 26015

const HIP_VERSION_GITHASH = "fc0010cf6a"

const HIP_VERSION_BUILD_ID = 0

const HIP_VERSION_BUILD_NAME = ""

const HIP_VERSION = HIP_VERSION_MAJOR * 10000000 + HIP_VERSION_MINOR * 100000 +
                    HIP_VERSION_PATCH

const __HIP_HAS_GET_PCH = 1

