const miopenAcceleratorQueue_t = Cint

struct miopenHandle end

const miopenHandle_t = Ptr{miopenHandle}

@cenum miopenStatus_t::UInt32 begin
    miopenStatusSuccess = 0
    miopenStatusNotInitialized = 1
    miopenStatusInvalidValue = 2
    miopenStatusBadParm = 3
    miopenStatusAllocFailed = 4
    miopenStatusInternalError = 5
    miopenStatusNotImplemented = 6
    miopenStatusUnknownError = 7
    miopenStatusUnsupportedOp = 8
    miopenStatusGpuOperationsSkipped = 9
end

function miopenGetErrorString(error)
    ccall((:miopenGetErrorString, libMIOpen_path), Ptr{Cchar}, (miopenStatus_t,), error)
end

# typedef void * ( * miopenAllocatorFunction ) ( void * context , size_t sizeBytes )
const miopenAllocatorFunction = Ptr{Cvoid}

# typedef void ( * miopenDeallocatorFunction ) ( void * context , void * memory )
const miopenDeallocatorFunction = Ptr{Cvoid}

function miopenGetVersion(major, minor, patch)
    ccall((:miopenGetVersion, libMIOpen_path), miopenStatus_t, (Ptr{Csize_t}, Ptr{Csize_t}, Ptr{Csize_t}), major, minor, patch)
end

function miopenCreate(handle)
    ccall((:miopenCreate, libMIOpen_path), miopenStatus_t, (Ptr{miopenHandle_t},), handle)
end

function miopenCreateWithStream(handle, stream)
    ccall((:miopenCreateWithStream, libMIOpen_path), miopenStatus_t, (Ptr{miopenHandle_t}, miopenAcceleratorQueue_t), handle, stream)
end

function miopenDestroy(handle)
    ccall((:miopenDestroy, libMIOpen_path), miopenStatus_t, (miopenHandle_t,), handle)
end

function miopenSetStream(handle, streamID)
    ccall((:miopenSetStream, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenAcceleratorQueue_t), handle, streamID)
end

function miopenGetStream(handle, streamID)
    ccall((:miopenGetStream, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{miopenAcceleratorQueue_t}), handle, streamID)
end

function miopenSetAllocator(handle, allocator, deallocator, allocatorContext)
    ccall((:miopenSetAllocator, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenAllocatorFunction, miopenDeallocatorFunction, Ptr{Cvoid}), handle, allocator, deallocator, allocatorContext)
end

function miopenGetKernelTime(handle, time)
    ccall((:miopenGetKernelTime, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cfloat}), handle, time)
end

function miopenEnableProfiling(handle, enable)
    ccall((:miopenEnableProfiling, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Bool), handle, enable)
end

struct miopenFusionOpDescriptor
end

const miopenFusionOpDescriptor_t = Ptr{miopenFusionOpDescriptor}

struct miopenTensorDescriptor
end

const miopenTensorDescriptor_t = Ptr{miopenTensorDescriptor}

struct miopenConvolutionDescriptor
end

const miopenConvolutionDescriptor_t = Ptr{miopenConvolutionDescriptor}

struct miopenPoolingDescriptor
end

const miopenPoolingDescriptor_t = Ptr{miopenPoolingDescriptor}

struct miopenLRNDescriptor
end

const miopenLRNDescriptor_t = Ptr{miopenLRNDescriptor}

struct miopenActivationDescriptor
end

const miopenActivationDescriptor_t = Ptr{miopenActivationDescriptor}

struct miopenRNNDescriptor
end

const miopenRNNDescriptor_t = Ptr{miopenRNNDescriptor}

struct miopenCTCLossDescriptor
end

const miopenCTCLossDescriptor_t = Ptr{miopenCTCLossDescriptor}

struct miopenDropoutDescriptor
end

const miopenDropoutDescriptor_t = Ptr{miopenDropoutDescriptor}

struct miopenReduceTensorDescriptor
end

const miopenReduceTensorDescriptor_t = Ptr{miopenReduceTensorDescriptor}

@cenum miopenDataType_t::UInt32 begin
    miopenHalf = 0
    miopenFloat = 1
    miopenInt32 = 2
    miopenInt8 = 3
    miopenInt8x4 = 4
    miopenBFloat16 = 5
    miopenDouble = 6
end

@cenum miopenIndexType_t::UInt32 begin
    miopenIndexUint8 = 0
    miopenIndexUint16 = 1
    miopenIndexUint32 = 2
    miopenIndexUint64 = 3
end

@cenum miopenTensorOp_t::UInt32 begin
    miopenTensorOpAdd = 0
    miopenTensorOpMul = 1
    miopenTensorOpMin = 2
    miopenTensorOpMax = 3
end

@cenum miopenConvolutionMode_t::UInt32 begin
    miopenConvolution = 0
    miopenTranspose = 1
    miopenGroupConv = 2
    miopenDepthwise = 3
end

@cenum miopenPaddingMode_t::UInt32 begin
    miopenPaddingDefault = 0
    miopenPaddingSame = 1
    miopenPaddingValid = 2
end

@cenum miopenPoolingMode_t::UInt32 begin
    miopenPoolingMax = 0
    miopenPoolingAverage = 1
    miopenPoolingAverageInclusive = 2
end

@cenum miopenPoolingWorkspaceIndexMode_t::UInt32 begin
    miopenPoolingWorkspaceIndexMask = 0
    miopenPoolingWorkspaceIndexImage = 1
end

@cenum miopenLRNMode_t::UInt32 begin
    miopenLRNWithinChannel = 0
    miopenLRNCrossChannel = 1
end

@cenum miopenBatchNormMode_t::UInt32 begin
    miopenBNPerActivation = 0
    miopenBNSpatial = 1
end

@cenum miopenActivationMode_t::UInt32 begin
    miopenActivationPASTHRU = 0
    miopenActivationLOGISTIC = 1
    miopenActivationTANH = 2
    miopenActivationRELU = 3
    miopenActivationSOFTRELU = 4
    miopenActivationABS = 5
    miopenActivationPOWER = 6
    miopenActivationCLIPPEDRELU = 7
    miopenActivationLEAKYRELU = 8
    miopenActivationELU = 9
end

@cenum miopenSoftmaxAlgorithm_t::UInt32 begin
    MIOPEN_SOFTMAX_FAST = 0
    MIOPEN_SOFTMAX_ACCURATE = 1
    MIOPEN_SOFTMAX_LOG = 2
end

@cenum miopenSoftmaxMode_t::UInt32 begin
    MIOPEN_SOFTMAX_MODE_INSTANCE = 0
    MIOPEN_SOFTMAX_MODE_CHANNEL = 1
end

@cenum miopenReduceTensorOp_t::UInt32 begin
    MIOPEN_REDUCE_TENSOR_ADD = 0
    MIOPEN_REDUCE_TENSOR_MUL = 1
    MIOPEN_REDUCE_TENSOR_MIN = 2
    MIOPEN_REDUCE_TENSOR_MAX = 3
    MIOPEN_REDUCE_TENSOR_AMAX = 4
    MIOPEN_REDUCE_TENSOR_AVG = 5
    MIOPEN_REDUCE_TENSOR_NORM1 = 6
    MIOPEN_REDUCE_TENSOR_NORM2 = 7
end

@cenum miopenNanPropagation_t::UInt32 begin
    MIOPEN_NOT_PROPAGATE_NAN = 0
    MIOPEN_PROPAGATE_NAN = 1
end

@cenum miopenReduceTensorIndices_t::UInt32 begin
    MIOPEN_REDUCE_TENSOR_NO_INDICES = 0
    MIOPEN_REDUCE_TENSOR_FLATTENED_INDICES = 1
end

@cenum miopenIndicesType_t::UInt32 begin
    MIOPEN_32BIT_INDICES = 0
    MIOPEN_64BIT_INDICES = 1
    MIOPEN_16BIT_INDICES = 2
    MIOPEN_8BIT_INDICES = 3
end

@cenum miopenConvolutionAttrib_t::UInt32 begin
    MIOPEN_CONVOLUTION_ATTRIB_FP16_ALT_IMPL = 0
end

function miopenCreateTensorDescriptor(tensorDesc)
    ccall((:miopenCreateTensorDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenTensorDescriptor_t},), tensorDesc)
end

function miopenSet4dTensorDescriptor(tensorDesc, dataType, n, c, h, w)
    ccall((:miopenSet4dTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, miopenDataType_t, Cint, Cint, Cint, Cint), tensorDesc, dataType, n, c, h, w)
end

function miopenSet4dTensorDescriptorEx(tensorDesc, dataType, n, c, h, w, nStride, cStride, hStride, wStride)
    ccall((:miopenSet4dTensorDescriptorEx, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, miopenDataType_t, Cint, Cint, Cint, Cint, Cint, Cint, Cint, Cint), tensorDesc, dataType, n, c, h, w, nStride, cStride, hStride, wStride)
end

function miopenGet4dTensorDescriptor(tensorDesc, dataType, n, c, h, w, nStride, cStride, hStride, wStride)
    ccall((:miopenGet4dTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{miopenDataType_t}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), tensorDesc, dataType, n, c, h, w, nStride, cStride, hStride, wStride)
end

function miopenSetTensorDescriptor(tensorDesc, dataType, nbDims, dimsA, stridesA)
    ccall((:miopenSetTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, miopenDataType_t, Cint, Ptr{Cint}, Ptr{Cint}), tensorDesc, dataType, nbDims, dimsA, stridesA)
end

function miopenGetTensorDescriptorSize(tensorDesc, size)
    ccall((:miopenGetTensorDescriptorSize, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{Cint}), tensorDesc, size)
end

function miopenGetTensorDescriptor(tensorDesc, dataType, dimsA, stridesA)
    ccall((:miopenGetTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{miopenDataType_t}, Ptr{Cint}, Ptr{Cint}), tensorDesc, dataType, dimsA, stridesA)
end

function miopenDestroyTensorDescriptor(tensorDesc)
    ccall((:miopenDestroyTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t,), tensorDesc)
end

function miopenOpTensor(handle, tensorOp, alpha1, aDesc, A, alpha2, bDesc, B, beta, cDesc, C)
    ccall((:miopenOpTensor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorOp_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, tensorOp, alpha1, aDesc, A, alpha2, bDesc, B, beta, cDesc, C)
end

function miopenSetTensor(handle, yDesc, y, alpha)
    ccall((:miopenSetTensor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}), handle, yDesc, y, alpha)
end

function miopenScaleTensor(handle, yDesc, y, alpha)
    ccall((:miopenScaleTensor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}), handle, yDesc, y, alpha)
end

function miopenGetTensorNumBytes(tensorDesc, numBytes)
    ccall((:miopenGetTensorNumBytes, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{Csize_t}), tensorDesc, numBytes)
end

function miopenTransformTensor(handle, alpha, xDesc, x, beta, yDesc, y)
    ccall((:miopenTransformTensor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, alpha, xDesc, x, beta, yDesc, y)
end

function miopenCreateConvolutionDescriptor(convDesc)
    ccall((:miopenCreateConvolutionDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenConvolutionDescriptor_t},), convDesc)
end

function miopenInitConvolutionDescriptor(convDesc, c_mode, pad_h, pad_w, stride_h, stride_w, dilation_h, dilation_w)
    ccall((:miopenInitConvolutionDescriptor, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, miopenConvolutionMode_t, Cint, Cint, Cint, Cint, Cint, Cint), convDesc, c_mode, pad_h, pad_w, stride_h, stride_w, dilation_h, dilation_w)
end

function miopenInitConvolutionNdDescriptor(convDesc, spatialDim, padA, strideA, dilationA, c_mode)
    ccall((:miopenInitConvolutionNdDescriptor, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, miopenConvolutionMode_t), convDesc, spatialDim, padA, strideA, dilationA, c_mode)
end

function miopenGetConvolutionDescriptor(convDesc, c_mode, pad_h, pad_w, stride_h, stride_w, dilation_h, dilation_w)
    ccall((:miopenGetConvolutionDescriptor, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Ptr{miopenConvolutionMode_t}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), convDesc, c_mode, pad_h, pad_w, stride_h, stride_w, dilation_h, dilation_w)
end

function miopenGetConvolutionNdDescriptor(convDesc, requestedSpatialDim, spatialDim, padA, strideA, dilationA, c_mode)
    ccall((:miopenGetConvolutionNdDescriptor, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{miopenConvolutionMode_t}), convDesc, requestedSpatialDim, spatialDim, padA, strideA, dilationA, c_mode)
end

function miopenSetConvolutionGroupCount(convDesc, groupCount)
    ccall((:miopenSetConvolutionGroupCount, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Cint), convDesc, groupCount)
end

function miopenSetTransposeConvOutputPadding(convDesc, adj_h, adj_w)
    ccall((:miopenSetTransposeConvOutputPadding, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Cint, Cint), convDesc, adj_h, adj_w)
end

function miopenSetTransposeConvNdOutputPadding(convDesc, spatialDim, adjA)
    ccall((:miopenSetTransposeConvNdOutputPadding, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, Cint, Ptr{Cint}), convDesc, spatialDim, adjA)
end

function miopenGetConvolutionForwardOutputDim(convDesc, inputTensorDesc, filterDesc, n, c, h, w)
    ccall((:miopenGetConvolutionForwardOutputDim, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), convDesc, inputTensorDesc, filterDesc, n, c, h, w)
end

function miopenGetConvolutionNdForwardOutputDim(convDesc, inputTensorDesc, filterDesc, nDim, outputTensorDimA)
    ccall((:miopenGetConvolutionNdForwardOutputDim, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cint}, Ptr{Cint}), convDesc, inputTensorDesc, filterDesc, nDim, outputTensorDimA)
end

function miopenDestroyConvolutionDescriptor(convDesc)
    ccall((:miopenDestroyConvolutionDescriptor, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t,), convDesc)
end

function miopenSetConvolutionAttribute(convDesc, attr, value)
    ccall((:miopenSetConvolutionAttribute, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, miopenConvolutionAttrib_t, Cint), convDesc, attr, value)
end

function miopenGetConvolutionAttribute(convDesc, attr, value)
    ccall((:miopenGetConvolutionAttribute, libMIOpen_path), miopenStatus_t, (miopenConvolutionDescriptor_t, miopenConvolutionAttrib_t, Ptr{Cint}), convDesc, attr, value)
end

@cenum miopenConvFwdAlgorithm_t::UInt32 begin
    miopenConvolutionFwdAlgoGEMM = 0
    miopenConvolutionFwdAlgoDirect = 1
    miopenConvolutionFwdAlgoFFT = 2
    miopenConvolutionFwdAlgoWinograd = 3
    miopenConvolutionFwdAlgoImplicitGEMM = 5
end

@cenum miopenConvBwdWeightsAlgorithm_t::UInt32 begin
    miopenConvolutionBwdWeightsAlgoGEMM = 0
    miopenConvolutionBwdWeightsAlgoDirect = 1
    miopenConvolutionBwdWeightsAlgoWinograd = 3
    miopenConvolutionBwdWeightsAlgoImplicitGEMM = 5
end

@cenum miopenConvBwdDataAlgorithm_t::UInt32 begin
    miopenConvolutionBwdDataAlgoGEMM = 0
    miopenConvolutionBwdDataAlgoDirect = 1
    miopenConvolutionBwdDataAlgoFFT = 2
    miopenConvolutionBwdDataAlgoWinograd = 3
    miopenTransposeBwdDataAlgoGEMM = 4
    miopenConvolutionBwdDataAlgoImplicitGEMM = 5
end

@cenum miopenConvAlgorithm_t::UInt32 begin
    miopenConvolutionAlgoGEMM = 0
    miopenConvolutionAlgoDirect = 1
    miopenConvolutionAlgoFFT = 2
    miopenConvolutionAlgoWinograd = 3
    miopenConvolutionAlgoImplicitGEMM = 5
end

struct miopenConvAlgoPerf_t
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{miopenConvAlgoPerf_t}, f::Symbol)
    f === :fwd_algo && return Ptr{miopenConvFwdAlgorithm_t}(x + 0)
    f === :bwd_weights_algo && return Ptr{miopenConvBwdWeightsAlgorithm_t}(x + 0)
    f === :bwd_data_algo && return Ptr{miopenConvBwdDataAlgorithm_t}(x + 0)
    f === :time && return Ptr{Cfloat}(x + 4)
    f === :memory && return Ptr{Csize_t}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::miopenConvAlgoPerf_t, f::Symbol)
    r = Ref{miopenConvAlgoPerf_t}(x)
    ptr = Base.unsafe_convert(Ptr{miopenConvAlgoPerf_t}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{miopenConvAlgoPerf_t}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct miopenConvSolution_t
    time::Cfloat
    workspace_size::Csize_t
    solution_id::Cint
    algorithm::miopenConvAlgorithm_t
end

function miopenConvolutionForwardGetSolutionCount(handle, wDesc, xDesc, convDesc, yDesc, solutionCount)
    ccall((:miopenConvolutionForwardGetSolutionCount, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, wDesc, xDesc, convDesc, yDesc, solutionCount)
end

function miopenConvolutionForwardGetSolution(handle, wDesc, xDesc, convDesc, yDesc, maxSolutionCount, solutionCount, solutions)
    ccall((:miopenConvolutionForwardGetSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Csize_t, Ptr{Csize_t}, Ptr{miopenConvSolution_t}), handle, wDesc, xDesc, convDesc, yDesc, maxSolutionCount, solutionCount, solutions)
end

function miopenConvolutionForwardGetSolutionWorkspaceSize(handle, wDesc, xDesc, convDesc, yDesc, solution_id, workSpaceSize)
    ccall((:miopenConvolutionForwardGetSolutionWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint, Ptr{Csize_t}), handle, wDesc, xDesc, convDesc, yDesc, solution_id, workSpaceSize)
end

function miopenConvolutionForwardCompileSolution(handle, wDesc, xDesc, convDesc, yDesc, solution_id)
    ccall((:miopenConvolutionForwardCompileSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint), handle, wDesc, xDesc, convDesc, yDesc, solution_id)
end

function miopenConvolutionForwardImmediate(handle, wDesc, w, xDesc, x, convDesc, yDesc, y, workSpace, workSpaceSize, solution_id)
    ccall((:miopenConvolutionForwardImmediate, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Cint), handle, wDesc, w, xDesc, x, convDesc, yDesc, y, workSpace, workSpaceSize, solution_id)
end

function miopenConvolutionBackwardDataGetSolutionCount(handle, dyDesc, wDesc, convDesc, dxDesc, solutionCount)
    ccall((:miopenConvolutionBackwardDataGetSolutionCount, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, dyDesc, wDesc, convDesc, dxDesc, solutionCount)
end

function miopenConvolutionBackwardDataGetSolution(handle, dyDesc, wDesc, convDesc, dxDesc, maxSolutionCount, solutionCount, solutions)
    ccall((:miopenConvolutionBackwardDataGetSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Csize_t, Ptr{Csize_t}, Ptr{miopenConvSolution_t}), handle, dyDesc, wDesc, convDesc, dxDesc, maxSolutionCount, solutionCount, solutions)
end

function miopenConvolutionBackwardDataGetSolutionWorkspaceSize(handle, dyDesc, wDesc, convDesc, dxDesc, solution_id, workSpaceSize)
    ccall((:miopenConvolutionBackwardDataGetSolutionWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint, Ptr{Csize_t}), handle, dyDesc, wDesc, convDesc, dxDesc, solution_id, workSpaceSize)
end

function miopenConvolutionBackwardDataCompileSolution(handle, dyDesc, wDesc, convDesc, dxDesc, solution_id)
    ccall((:miopenConvolutionBackwardDataCompileSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint), handle, dyDesc, wDesc, convDesc, dxDesc, solution_id)
end

function miopenConvolutionBackwardDataImmediate(handle, dyDesc, dy, wDesc, w, convDesc, dxDesc, dx, workSpace, workSpaceSize, solution_id)
    ccall((:miopenConvolutionBackwardDataImmediate, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Cint), handle, dyDesc, dy, wDesc, w, convDesc, dxDesc, dx, workSpace, workSpaceSize, solution_id)
end

function miopenConvolutionBackwardWeightsGetSolutionCount(handle, dyDesc, xDesc, convDesc, dwDesc, solutionCount)
    ccall((:miopenConvolutionBackwardWeightsGetSolutionCount, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, dyDesc, xDesc, convDesc, dwDesc, solutionCount)
end

function miopenConvolutionBackwardWeightsGetSolution(handle, dyDesc, xDesc, convDesc, dwDesc, maxSolutionCount, solutionCount, solutions)
    ccall((:miopenConvolutionBackwardWeightsGetSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Csize_t, Ptr{Csize_t}, Ptr{miopenConvSolution_t}), handle, dyDesc, xDesc, convDesc, dwDesc, maxSolutionCount, solutionCount, solutions)
end

function miopenConvolutionBackwardWeightsGetSolutionWorkspaceSize(handle, dyDesc, xDesc, convDesc, dwDesc, solution_id, workSpaceSize)
    ccall((:miopenConvolutionBackwardWeightsGetSolutionWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint, Ptr{Csize_t}), handle, dyDesc, xDesc, convDesc, dwDesc, solution_id, workSpaceSize)
end

function miopenConvolutionBackwardWeightsCompileSolution(handle, dyDesc, xDesc, convDesc, dwDesc, solution_id)
    ccall((:miopenConvolutionBackwardWeightsCompileSolution, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Cint), handle, dyDesc, xDesc, convDesc, dwDesc, solution_id)
end

function miopenConvolutionBackwardWeightsImmediate(handle, dyDesc, dy, xDesc, x, convDesc, dwDesc, dw, workSpace, workSpaceSize, solution_id)
    ccall((:miopenConvolutionBackwardWeightsImmediate, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Cint), handle, dyDesc, dy, xDesc, x, convDesc, dwDesc, dw, workSpace, workSpaceSize, solution_id)
end

function miopenConvolutionForwardGetWorkSpaceSize(handle, wDesc, xDesc, convDesc, yDesc, workSpaceSize)
    ccall((:miopenConvolutionForwardGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, wDesc, xDesc, convDesc, yDesc, workSpaceSize)
end

function miopenFindConvolutionForwardAlgorithm(handle, xDesc, x, wDesc, w, convDesc, yDesc, y, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
    ccall((:miopenFindConvolutionForwardAlgorithm, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{miopenConvAlgoPerf_t}, Ptr{Cvoid}, Csize_t, Bool), handle, xDesc, x, wDesc, w, convDesc, yDesc, y, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
end

function miopenConvolutionForward(handle, alpha, xDesc, x, wDesc, w, convDesc, algo, beta, yDesc, y, workSpace, workSpaceSize)
    ccall((:miopenConvolutionForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenConvFwdAlgorithm_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, alpha, xDesc, x, wDesc, w, convDesc, algo, beta, yDesc, y, workSpace, workSpaceSize)
end

function miopenConvolutionForwardBias(handle, alpha, bDesc, b, beta, yDesc, y)
    ccall((:miopenConvolutionForwardBias, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, alpha, bDesc, b, beta, yDesc, y)
end

function miopenConvolutionBackwardDataGetWorkSpaceSize(handle, dyDesc, wDesc, convDesc, dxDesc, workSpaceSize)
    ccall((:miopenConvolutionBackwardDataGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, dyDesc, wDesc, convDesc, dxDesc, workSpaceSize)
end

function miopenFindConvolutionBackwardDataAlgorithm(handle, dyDesc, dy, wDesc, w, convDesc, dxDesc, dx, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
    ccall((:miopenFindConvolutionBackwardDataAlgorithm, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{miopenConvAlgoPerf_t}, Ptr{Cvoid}, Csize_t, Bool), handle, dyDesc, dy, wDesc, w, convDesc, dxDesc, dx, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
end

function miopenConvolutionBackwardData(handle, alpha, dyDesc, dy, wDesc, w, convDesc, algo, beta, dxDesc, dx, workSpace, workSpaceSize)
    ccall((:miopenConvolutionBackwardData, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenConvBwdDataAlgorithm_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, alpha, dyDesc, dy, wDesc, w, convDesc, algo, beta, dxDesc, dx, workSpace, workSpaceSize)
end

function miopenConvolutionBackwardWeightsGetWorkSpaceSize(handle, dyDesc, xDesc, convDesc, dwDesc, workSpaceSize)
    ccall((:miopenConvolutionBackwardWeightsGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, dyDesc, xDesc, convDesc, dwDesc, workSpaceSize)
end

function miopenFindConvolutionBackwardWeightsAlgorithm(handle, dyDesc, dy, xDesc, x, convDesc, dwDesc, dw, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
    ccall((:miopenFindConvolutionBackwardWeightsAlgorithm, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, Ptr{Cint}, Ptr{miopenConvAlgoPerf_t}, Ptr{Cvoid}, Csize_t, Bool), handle, dyDesc, dy, xDesc, x, convDesc, dwDesc, dw, requestAlgoCount, returnedAlgoCount, perfResults, workSpace, workSpaceSize, exhaustiveSearch)
end

function miopenConvolutionBackwardWeights(handle, alpha, dyDesc, dy, xDesc, x, convDesc, algo, beta, dwDesc, dw, workSpace, workSpaceSize)
    ccall((:miopenConvolutionBackwardWeights, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenConvolutionDescriptor_t, miopenConvBwdWeightsAlgorithm_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, alpha, dyDesc, dy, xDesc, x, convDesc, algo, beta, dwDesc, dw, workSpace, workSpaceSize)
end

function miopenConvolutionBackwardBias(handle, alpha, dyDesc, dy, beta, dbDesc, db)
    ccall((:miopenConvolutionBackwardBias, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, alpha, dyDesc, dy, beta, dbDesc, db)
end

function miopenCreatePoolingDescriptor(poolDesc)
    ccall((:miopenCreatePoolingDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenPoolingDescriptor_t},), poolDesc)
end

function miopenSetPoolingIndexType(poolDesc, index_type)
    ccall((:miopenSetPoolingIndexType, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenIndexType_t), poolDesc, index_type)
end

function miopenGetPoolingIndexType(poolDesc, index_type)
    ccall((:miopenGetPoolingIndexType, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, Ptr{miopenIndexType_t}), poolDesc, index_type)
end

function miopenSetPoolingWorkSpaceIndexMode(poolDesc, workspace_index)
    ccall((:miopenSetPoolingWorkSpaceIndexMode, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenPoolingWorkspaceIndexMode_t), poolDesc, workspace_index)
end

function miopenGetPoolingWorkSpaceIndexMode(poolDesc, workspace_index)
    ccall((:miopenGetPoolingWorkSpaceIndexMode, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, Ptr{miopenPoolingWorkspaceIndexMode_t}), poolDesc, workspace_index)
end

function miopenSet2dPoolingDescriptor(poolDesc, mode, windowHeight, windowWidth, pad_h, pad_w, stride_h, stride_w)
    ccall((:miopenSet2dPoolingDescriptor, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenPoolingMode_t, Cint, Cint, Cint, Cint, Cint, Cint), poolDesc, mode, windowHeight, windowWidth, pad_h, pad_w, stride_h, stride_w)
end

function miopenGet2dPoolingDescriptor(poolDesc, mode, windowHeight, windowWidth, pad_h, pad_w, stride_h, stride_w)
    ccall((:miopenGet2dPoolingDescriptor, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, Ptr{miopenPoolingMode_t}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), poolDesc, mode, windowHeight, windowWidth, pad_h, pad_w, stride_h, stride_w)
end

function miopenGetPoolingForwardOutputDim(poolDesc, tensorDesc, n, c, h, w)
    ccall((:miopenGetPoolingForwardOutputDim, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenTensorDescriptor_t, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), poolDesc, tensorDesc, n, c, h, w)
end

function miopenSetNdPoolingDescriptor(poolDesc, mode, nbDims, windowDimA, padA, stridesA)
    ccall((:miopenSetNdPoolingDescriptor, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenPoolingMode_t, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), poolDesc, mode, nbDims, windowDimA, padA, stridesA)
end

function miopenGetNdPoolingDescriptor(poolDesc, nbDimsRequested, mode, nbDims, windowDimA, padA, stridesA)
    ccall((:miopenGetNdPoolingDescriptor, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, Cint, Ptr{miopenPoolingMode_t}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), poolDesc, nbDimsRequested, mode, nbDims, windowDimA, padA, stridesA)
end

function miopenGetPoolingNdForwardOutputDim(poolDesc, tensorDesc, dims, tensorDimArr)
    ccall((:miopenGetPoolingNdForwardOutputDim, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenTensorDescriptor_t, Cint, Ptr{Cint}), poolDesc, tensorDesc, dims, tensorDimArr)
end

function miopenPoolingGetWorkSpaceSize(yDesc, workSpaceSize)
    ccall((:miopenPoolingGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{Csize_t}), yDesc, workSpaceSize)
end

function miopenPoolingGetWorkSpaceSizeV2(poolDesc, yDesc, workSpaceSize)
    ccall((:miopenPoolingGetWorkSpaceSizeV2, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), poolDesc, yDesc, workSpaceSize)
end

function miopenPoolingForward(handle, poolDesc, alpha, xDesc, x, beta, yDesc, y, do_backward, workSpace, workSpaceSize)
    ccall((:miopenPoolingForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenPoolingDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Bool, Ptr{Cvoid}, Csize_t), handle, poolDesc, alpha, xDesc, x, beta, yDesc, y, do_backward, workSpace, workSpaceSize)
end

function miopenPoolingBackward(handle, poolDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx, workSpace)
    ccall((:miopenPoolingBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenPoolingDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}), handle, poolDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx, workSpace)
end

function miopenDestroyPoolingDescriptor(poolDesc)
    ccall((:miopenDestroyPoolingDescriptor, libMIOpen_path), miopenStatus_t, (miopenPoolingDescriptor_t,), poolDesc)
end

function miopenCreateLRNDescriptor(lrnDesc)
    ccall((:miopenCreateLRNDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenLRNDescriptor_t},), lrnDesc)
end

function miopenSetLRNDescriptor(lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
    ccall((:miopenSetLRNDescriptor, libMIOpen_path), miopenStatus_t, (miopenLRNDescriptor_t, miopenLRNMode_t, Cuint, Cdouble, Cdouble, Cdouble), lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
end

function miopenGetLRNDescriptor(lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
    ccall((:miopenGetLRNDescriptor, libMIOpen_path), miopenStatus_t, (miopenLRNDescriptor_t, Ptr{miopenLRNMode_t}, Ptr{Cuint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), lrnDesc, mode, lrnN, lrnAlpha, lrnBeta, lrnK)
end

function miopenLRNGetWorkSpaceSize(yDesc, workSpaceSize)
    ccall((:miopenLRNGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{Csize_t}), yDesc, workSpaceSize)
end

function miopenLRNForward(handle, lrnDesc, alpha, xDesc, x, beta, yDesc, y, do_backward, workSpace)
    ccall((:miopenLRNForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenLRNDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Bool, Ptr{Cvoid}), handle, lrnDesc, alpha, xDesc, x, beta, yDesc, y, do_backward, workSpace)
end

function miopenLRNBackward(handle, lrnDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx, workSpace)
    ccall((:miopenLRNBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenLRNDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}), handle, lrnDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx, workSpace)
end

function miopenDestroyLRNDescriptor(lrnDesc)
    ccall((:miopenDestroyLRNDescriptor, libMIOpen_path), miopenStatus_t, (miopenLRNDescriptor_t,), lrnDesc)
end

function miopenDeriveBNTensorDescriptor(derivedBnDesc, xDesc, bn_mode)
    ccall((:miopenDeriveBNTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenBatchNormMode_t), derivedBnDesc, xDesc, bn_mode)
end

function miopenBatchNormalizationForwardTraining(handle, bn_mode, alpha, beta, xDesc, x, yDesc, y, bnScaleBiasMeanVarDesc, bnScale, bnBias, expAvgFactor, resultRunningMean, resultRunningVariance, epsilon, resultSaveMean, resultSaveInvVariance)
    ccall((:miopenBatchNormalizationForwardTraining, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenBatchNormMode_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Ptr{Cvoid}, Ptr{Cvoid}), handle, bn_mode, alpha, beta, xDesc, x, yDesc, y, bnScaleBiasMeanVarDesc, bnScale, bnBias, expAvgFactor, resultRunningMean, resultRunningVariance, epsilon, resultSaveMean, resultSaveInvVariance)
end

function miopenBatchNormalizationForwardInference(handle, bn_mode, alpha, beta, xDesc, x, yDesc, y, bnScaleBiasMeanVarDesc, bnScale, bnBias, estimatedMean, estimatedVariance, epsilon)
    ccall((:miopenBatchNormalizationForwardInference, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenBatchNormMode_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble), handle, bn_mode, alpha, beta, xDesc, x, yDesc, y, bnScaleBiasMeanVarDesc, bnScale, bnBias, estimatedMean, estimatedVariance, epsilon)
end

function miopenBatchNormalizationBackward(handle, bn_mode, alphaDataDiff, betaDataDiff, alphaParamDiff, betaParamDiff, xDesc, x, dyDesc, dy, dxDesc, dx, bnScaleBiasDiffDesc, bnScale, resultBnScaleDiff, resultBnBiasDiff, epsilon, savedMean, savedInvVariance)
    ccall((:miopenBatchNormalizationBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenBatchNormMode_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Ptr{Cvoid}, Ptr{Cvoid}), handle, bn_mode, alphaDataDiff, betaDataDiff, alphaParamDiff, betaParamDiff, xDesc, x, dyDesc, dy, dxDesc, dx, bnScaleBiasDiffDesc, bnScale, resultBnScaleDiff, resultBnBiasDiff, epsilon, savedMean, savedInvVariance)
end

function miopenCreateActivationDescriptor(activDesc)
    ccall((:miopenCreateActivationDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenActivationDescriptor_t},), activDesc)
end

function miopenSetActivationDescriptor(activDesc, mode, activAlpha, activBeta, activGamma)
    ccall((:miopenSetActivationDescriptor, libMIOpen_path), miopenStatus_t, (miopenActivationDescriptor_t, miopenActivationMode_t, Cdouble, Cdouble, Cdouble), activDesc, mode, activAlpha, activBeta, activGamma)
end

function miopenGetActivationDescriptor(activDesc, mode, activAlpha, activBeta, activGamma)
    ccall((:miopenGetActivationDescriptor, libMIOpen_path), miopenStatus_t, (miopenActivationDescriptor_t, Ptr{miopenActivationMode_t}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), activDesc, mode, activAlpha, activBeta, activGamma)
end

function miopenActivationForward(handle, activDesc, alpha, xDesc, x, beta, yDesc, y)
    ccall((:miopenActivationForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenActivationDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, activDesc, alpha, xDesc, x, beta, yDesc, y)
end

function miopenActivationBackward(handle, activDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx)
    ccall((:miopenActivationBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenActivationDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, activDesc, alpha, yDesc, y, dyDesc, dy, xDesc, x, beta, dxDesc, dx)
end

function miopenDestroyActivationDescriptor(activDesc)
    ccall((:miopenDestroyActivationDescriptor, libMIOpen_path), miopenStatus_t, (miopenActivationDescriptor_t,), activDesc)
end

function miopenSoftmaxForward(handle, alpha, xDesc, x, beta, yDesc, y)
    ccall((:miopenSoftmaxForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, alpha, xDesc, x, beta, yDesc, y)
end

function miopenSoftmaxBackward(handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx)
    ccall((:miopenSoftmaxBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx)
end

function miopenSoftmaxForward_V2(handle, alpha, xDesc, x, beta, yDesc, y, algorithm, mode)
    ccall((:miopenSoftmaxForward_V2, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenSoftmaxAlgorithm_t, miopenSoftmaxMode_t), handle, alpha, xDesc, x, beta, yDesc, y, algorithm, mode)
end

function miopenSoftmaxBackward_V2(handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx, algorithm, mode)
    ccall((:miopenSoftmaxBackward_V2, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenSoftmaxAlgorithm_t, miopenSoftmaxMode_t), handle, alpha, yDesc, y, dyDesc, dy, beta, dxDesc, dx, algorithm, mode)
end

struct miopenFusionPlanDescriptor
end

const miopenFusionPlanDescriptor_t = Ptr{miopenFusionPlanDescriptor}

struct miopenOperatorDescriptor
end

const miopenOperatorDescriptor_t = Ptr{miopenOperatorDescriptor}

struct miopenOperatorArgs
end

const miopenOperatorArgs_t = Ptr{miopenOperatorArgs}

@cenum miopenFusionDirection_t::UInt32 begin
    miopenVerticalFusion = 0
    miopenHorizontalFusion = 1
end

function miopenCreateFusionPlan(fusePlanDesc, fuseDirection, inputDesc)
    ccall((:miopenCreateFusionPlan, libMIOpen_path), miopenStatus_t, (Ptr{miopenFusionPlanDescriptor_t}, miopenFusionDirection_t, miopenTensorDescriptor_t), fusePlanDesc, fuseDirection, inputDesc)
end

function miopenDestroyFusionPlan(fusePlanDesc)
    ccall((:miopenDestroyFusionPlan, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t,), fusePlanDesc)
end

function miopenCompileFusionPlan(handle, fusePlanDesc)
    ccall((:miopenCompileFusionPlan, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenFusionPlanDescriptor_t), handle, fusePlanDesc)
end

function miopenFusionPlanGetOp(fusePlanDesc, op_idx, op)
    ccall((:miopenFusionPlanGetOp, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Cint, Ptr{miopenFusionOpDescriptor_t}), fusePlanDesc, op_idx, op)
end

function miopenFusionPlanGetWorkSpaceSize(handle, fusePlanDesc, workSpaceSize, algo)
    ccall((:miopenFusionPlanGetWorkSpaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenFusionPlanDescriptor_t, Ptr{Csize_t}, miopenConvFwdAlgorithm_t), handle, fusePlanDesc, workSpaceSize, algo)
end

function miopenFusionPlanConvolutionGetAlgo(fusePlanDesc, requestAlgoCount, returnedAlgoCount, returnedAlgos)
    ccall((:miopenFusionPlanConvolutionGetAlgo, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Cint, Ptr{Cint}, Ptr{miopenConvFwdAlgorithm_t}), fusePlanDesc, requestAlgoCount, returnedAlgoCount, returnedAlgos)
end

function miopenFusionPlanConvolutionSetAlgo(fusePlanDesc, algo)
    ccall((:miopenFusionPlanConvolutionSetAlgo, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, miopenConvFwdAlgorithm_t), fusePlanDesc, algo)
end

function miopenCreateOpConvForward(fusePlanDesc, convOp, convDesc, wDesc)
    ccall((:miopenCreateOpConvForward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenConvolutionDescriptor_t, miopenTensorDescriptor_t), fusePlanDesc, convOp, convDesc, wDesc)
end

function miopenCreateOpActivationForward(fusePlanDesc, activFwdOp, mode)
    ccall((:miopenCreateOpActivationForward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenActivationMode_t), fusePlanDesc, activFwdOp, mode)
end

function miopenCreateOpActivationBackward(fusePlanDesc, activBwdOp, mode)
    ccall((:miopenCreateOpActivationBackward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenActivationMode_t), fusePlanDesc, activBwdOp, mode)
end

function miopenCreateOpBiasForward(fusePlanDesc, biasOp, bDesc)
    ccall((:miopenCreateOpBiasForward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenTensorDescriptor_t), fusePlanDesc, biasOp, bDesc)
end

function miopenCreateOpBatchNormInference(fusePlanDesc, bnOp, bn_mode, bnScaleBiasMeanVarDesc)
    ccall((:miopenCreateOpBatchNormInference, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenBatchNormMode_t, miopenTensorDescriptor_t), fusePlanDesc, bnOp, bn_mode, bnScaleBiasMeanVarDesc)
end

function miopenCreateOpBatchNormForward(fusePlanDesc, bnFwdOp, bn_mode, runningMeanVariance)
    ccall((:miopenCreateOpBatchNormForward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenBatchNormMode_t, Bool), fusePlanDesc, bnFwdOp, bn_mode, runningMeanVariance)
end

function miopenCreateOpBatchNormBackward(fusePlanDesc, bnBwdOp, bn_mode)
    ccall((:miopenCreateOpBatchNormBackward, libMIOpen_path), miopenStatus_t, (miopenFusionPlanDescriptor_t, Ptr{miopenFusionOpDescriptor_t}, miopenBatchNormMode_t), fusePlanDesc, bnBwdOp, bn_mode)
end

function miopenCreateOperatorArgs(args)
    ccall((:miopenCreateOperatorArgs, libMIOpen_path), miopenStatus_t, (Ptr{miopenOperatorArgs_t},), args)
end

function miopenDestroyOperatorArgs(args)
    ccall((:miopenDestroyOperatorArgs, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t,), args)
end

function miopenSetOpArgsConvForward(args, convOp, alpha, beta, w)
    ccall((:miopenSetOpArgsConvForward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), args, convOp, alpha, beta, w)
end

function miopenSetOpArgsActivForward(args, activFwdOp, alpha, beta, activAlpha, activBeta, activGamma)
    ccall((:miopenSetOpArgsActivForward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Cdouble, Cdouble), args, activFwdOp, alpha, beta, activAlpha, activBeta, activGamma)
end

function miopenSetOpArgsActivBackward(args, activBwdOp, alpha, beta, y, reserved, activAlpha, activBeta, activGamma)
    ccall((:miopenSetOpArgsActivBackward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Cdouble, Cdouble), args, activBwdOp, alpha, beta, y, reserved, activAlpha, activBeta, activGamma)
end

function miopenSetOpArgsBatchNormInference(args, bnOp, alpha, beta, bnScale, bnBias, estimatedMean, estimatedVariance, epsilon)
    ccall((:miopenSetOpArgsBatchNormInference, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble), args, bnOp, alpha, beta, bnScale, bnBias, estimatedMean, estimatedVariance, epsilon)
end

function miopenSetOpArgsBatchNormForward(args, bnOp, alpha, beta, bnScale, bnBias, savedMean, savedInvVariance, runningMean, runningVariance, expAvgFactor, epsilon)
    ccall((:miopenSetOpArgsBatchNormForward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cdouble, Cdouble), args, bnOp, alpha, beta, bnScale, bnBias, savedMean, savedInvVariance, runningMean, runningVariance, expAvgFactor, epsilon)
end

function miopenSetOpArgsBatchNormBackward(args, bnOp, alpha, beta, x, bnScale, bnBias, resultBnScaleDiff, resultBnBiasDiff, savedMean, savedInvVariance)
    ccall((:miopenSetOpArgsBatchNormBackward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), args, bnOp, alpha, beta, x, bnScale, bnBias, resultBnScaleDiff, resultBnBiasDiff, savedMean, savedInvVariance)
end

function miopenSetOpArgsBiasForward(args, biasOp, alpha, beta, bias)
    ccall((:miopenSetOpArgsBiasForward, libMIOpen_path), miopenStatus_t, (miopenOperatorArgs_t, miopenFusionOpDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), args, biasOp, alpha, beta, bias)
end

function miopenExecuteFusionPlan(handle, fusePlanDesc, inputDesc, input, outputDesc, output, args)
    ccall((:miopenExecuteFusionPlan, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenFusionPlanDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenOperatorArgs_t), handle, fusePlanDesc, inputDesc, input, outputDesc, output, args)
end

@cenum miopenRNNMode_t::UInt32 begin
    miopenRNNRELU = 0
    miopenRNNTANH = 1
    miopenLSTM = 2
    miopenGRU = 3
end

@cenum miopenRNNInputMode_t::UInt32 begin
    miopenRNNlinear = 0
    miopenRNNskip = 1
end

@cenum miopenRNNAlgo_t::UInt32 begin
    miopenRNNdefault = 0
    miopenRNNfundamental = 1
end

@cenum miopenRNNDirectionMode_t::UInt32 begin
    miopenRNNunidirection = 0
    miopenRNNbidirection = 1
end

@cenum miopenRNNBiasMode_t::UInt32 begin
    miopenRNNNoBias = 0
    miopenRNNwithBias = 1
end

@cenum miopenRNNGEMMalgoMode_t::UInt32 begin
    miopenRNNAlgoGEMM = 0
end

function miopenCreateRNNDescriptor(rnnDesc)
    ccall((:miopenCreateRNNDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenRNNDescriptor_t},), rnnDesc)
end

function miopenGetRNNDescriptor(rnnDesc, rnnMode, algoMode, inputMode, dirMode, biasMode, hiddenSize, layer)
    ccall((:miopenGetRNNDescriptor, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Ptr{miopenRNNMode_t}, Ptr{miopenRNNAlgo_t}, Ptr{miopenRNNInputMode_t}, Ptr{miopenRNNDirectionMode_t}, Ptr{miopenRNNBiasMode_t}, Ptr{Cint}, Ptr{Cint}), rnnDesc, rnnMode, algoMode, inputMode, dirMode, biasMode, hiddenSize, layer)
end

function miopenGetRNNDescriptor_V2(rnnDesc, hiddenSize, layer, dropoutDesc, inputMode, dirMode, rnnMode, biasMode, algoMode, dataType)
    ccall((:miopenGetRNNDescriptor_V2, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Ptr{Cint}, Ptr{Cint}, Ptr{miopenDropoutDescriptor_t}, Ptr{miopenRNNInputMode_t}, Ptr{miopenRNNDirectionMode_t}, Ptr{miopenRNNMode_t}, Ptr{miopenRNNBiasMode_t}, Ptr{miopenRNNAlgo_t}, Ptr{miopenDataType_t}), rnnDesc, hiddenSize, layer, dropoutDesc, inputMode, dirMode, rnnMode, biasMode, algoMode, dataType)
end

function miopenDestroyRNNDescriptor(rnnDesc)
    ccall((:miopenDestroyRNNDescriptor, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t,), rnnDesc)
end

function miopenSetRNNDescriptor(rnnDesc, hsize, nlayers, inMode, direction, rnnMode, biasMode, algo, dataType)
    ccall((:miopenSetRNNDescriptor, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Cint, Cint, miopenRNNInputMode_t, miopenRNNDirectionMode_t, miopenRNNMode_t, miopenRNNBiasMode_t, miopenRNNAlgo_t, miopenDataType_t), rnnDesc, hsize, nlayers, inMode, direction, rnnMode, biasMode, algo, dataType)
end

function miopenSetRNNDescriptor_V2(rnnDesc, hsize, nlayers, dropoutDesc, inMode, direction, rnnMode, biasMode, algo, dataType)
    ccall((:miopenSetRNNDescriptor_V2, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Cint, Cint, miopenDropoutDescriptor_t, miopenRNNInputMode_t, miopenRNNDirectionMode_t, miopenRNNMode_t, miopenRNNBiasMode_t, miopenRNNAlgo_t, miopenDataType_t), rnnDesc, hsize, nlayers, dropoutDesc, inMode, direction, rnnMode, biasMode, algo, dataType)
end

function miopenGetRNNWorkspaceSize(handle, rnnDesc, sequenceLen, xDesc, numBytes)
    ccall((:miopenGetRNNWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Csize_t}), handle, rnnDesc, sequenceLen, xDesc, numBytes)
end

function miopenGetRNNTrainingReserveSize(handle, rnnDesc, sequenceLen, xDesc, numBytes)
    ccall((:miopenGetRNNTrainingReserveSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Csize_t}), handle, rnnDesc, sequenceLen, xDesc, numBytes)
end

function miopenGetRNNParamsSize(handle, rnnDesc, xDesc, numBytes, dtype)
    ccall((:miopenGetRNNParamsSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}, miopenDataType_t), handle, rnnDesc, xDesc, numBytes, dtype)
end

function miopenGetRNNParamsDescriptor(handle, rnnDesc, xDesc, wDesc, dtype)
    ccall((:miopenGetRNNParamsDescriptor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, miopenDataType_t), handle, rnnDesc, xDesc, wDesc, dtype)
end

function miopenGetRNNInputTensorSize(handle, rnnDesc, seqLen, xDesc, numBytes)
    ccall((:miopenGetRNNInputTensorSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Csize_t}), handle, rnnDesc, seqLen, xDesc, numBytes)
end

function miopenGetRNNHiddenTensorSize(handle, rnnDesc, seqLen, xDesc, numBytes)
    ccall((:miopenGetRNNHiddenTensorSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Csize_t}), handle, rnnDesc, seqLen, xDesc, numBytes)
end

function miopenGetRNNLayerParamSize(handle, rnnDesc, layer, xDesc, paramID, numBytes)
    ccall((:miopenGetRNNLayerParamSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, Cint, Ptr{Csize_t}), handle, rnnDesc, layer, xDesc, paramID, numBytes)
end

function miopenGetRNNLayerBiasSize(handle, rnnDesc, layer, biasID, numBytes)
    ccall((:miopenGetRNNLayerBiasSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Cint, Ptr{Csize_t}), handle, rnnDesc, layer, biasID, numBytes)
end

function miopenGetRNNLayerParam(handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc, layerParam)
    ccall((:miopenGetRNNLayerParam, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc, layerParam)
end

function miopenGetRNNLayerBias(handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc, layerBias)
    ccall((:miopenGetRNNLayerBias, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc, layerBias)
end

function miopenGetRNNLayerParamOffset(rnnDesc, layer, xDesc, paramID, paramDesc, layerParamOffset)
    ccall((:miopenGetRNNLayerParamOffset, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, Cint, miopenTensorDescriptor_t, Ptr{Csize_t}), rnnDesc, layer, xDesc, paramID, paramDesc, layerParamOffset)
end

function miopenGetRNNLayerBiasOffset(rnnDesc, layer, xDesc, biasID, biasDesc, layerBiasOffset)
    ccall((:miopenGetRNNLayerBiasOffset, libMIOpen_path), miopenStatus_t, (miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, Cint, miopenTensorDescriptor_t, Ptr{Csize_t}), rnnDesc, layer, xDesc, biasID, biasDesc, layerBiasOffset)
end

function miopenSetRNNLayerParam(handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc, layerParam)
    ccall((:miopenSetRNNLayerParam, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, rnnDesc, layer, xDesc, wDesc, w, paramID, paramDesc, layerParam)
end

function miopenSetRNNLayerBias(handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc, layerBias)
    ccall((:miopenSetRNNLayerBias, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Cint, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, rnnDesc, layer, xDesc, wDesc, w, biasID, biasDesc, layerBias)
end

function miopenRNNForwardTraining(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
    ccall((:miopenRNNForwardTraining, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Ptr{Cvoid}, Csize_t), handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
end

function miopenRNNBackwardData(handle, rnnDesc, sequenceLen, yDesc, y, dyDesc, dy, dhyDesc, dhy, dcyDesc, dcy, wDesc, w, hxDesc, hx, cxDesc, cx, dxDesc, dx, dhxDesc, dhx, dcxDesc, dcx, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
    ccall((:miopenRNNBackwardData, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Ptr{Cvoid}, Csize_t), handle, rnnDesc, sequenceLen, yDesc, y, dyDesc, dy, dhyDesc, dhy, dcyDesc, dcy, wDesc, w, hxDesc, hx, cxDesc, cx, dxDesc, dx, dhxDesc, dhx, dcxDesc, dcx, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
end

function miopenRNNBackwardWeights(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, yDesc, y, dwDesc, dw, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
    ccall((:miopenRNNBackwardWeights, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t, Ptr{Cvoid}, Csize_t), handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, yDesc, y, dwDesc, dw, workSpace, workSpaceNumBytes, reserveSpace, reserveSpaceNumBytes)
end

function miopenRNNForwardInference(handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy, workSpace, workSpaceNumBytes)
    ccall((:miopenRNNForwardInference, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenRNNDescriptor_t, Cint, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{miopenTensorDescriptor_t}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, rnnDesc, sequenceLen, xDesc, x, hxDesc, hx, cxDesc, cx, wDesc, w, yDesc, y, hyDesc, hy, cyDesc, cy, workSpace, workSpaceNumBytes)
end

@cenum miopenCTCLossAlgo_t::UInt32 begin
    MIOPEN_CTC_LOSS_ALGO_DETERMINISTIC = 0
end

function miopenCreateCTCLossDescriptor(ctcLossDesc)
    ccall((:miopenCreateCTCLossDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenCTCLossDescriptor_t},), ctcLossDesc)
end

function miopenGetCTCLossDescriptor(ctcLossDesc, dataType, blank_label_id, apply_softmax_layer)
    ccall((:miopenGetCTCLossDescriptor, libMIOpen_path), miopenStatus_t, (miopenCTCLossDescriptor_t, Ptr{miopenDataType_t}, Ptr{Cint}, Ptr{Bool}), ctcLossDesc, dataType, blank_label_id, apply_softmax_layer)
end

function miopenDestroyCTCLossDescriptor(ctcLossDesc)
    ccall((:miopenDestroyCTCLossDescriptor, libMIOpen_path), miopenStatus_t, (miopenCTCLossDescriptor_t,), ctcLossDesc)
end

function miopenSetCTCLossDescriptor(ctcLossDesc, dataType, blank_label_id, apply_softmax_layer)
    ccall((:miopenSetCTCLossDescriptor, libMIOpen_path), miopenStatus_t, (miopenCTCLossDescriptor_t, miopenDataType_t, Cint, Bool), ctcLossDesc, dataType, blank_label_id, apply_softmax_layer)
end

function miopenGetCTCLossWorkspaceSize(handle, probsDesc, gradientsDesc, labels, labelLengths, inputLengths, algo, ctcLossDesc, workSpaceSize)
    ccall((:miopenGetCTCLossWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, miopenCTCLossAlgo_t, miopenCTCLossDescriptor_t, Ptr{Csize_t}), handle, probsDesc, gradientsDesc, labels, labelLengths, inputLengths, algo, ctcLossDesc, workSpaceSize)
end

function miopenCTCLoss(handle, probsDesc, probs, labels, labelLengths, inputLengths, losses, gradientsDesc, gradients, algo, ctcLossDesc, workSpace, workSpaceSize)
    ccall((:miopenCTCLoss, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenCTCLossAlgo_t, miopenCTCLossDescriptor_t, Ptr{Cvoid}, Csize_t), handle, probsDesc, probs, labels, labelLengths, inputLengths, losses, gradientsDesc, gradients, algo, ctcLossDesc, workSpace, workSpaceSize)
end

@cenum miopenRNGType_t::UInt32 begin
    MIOPEN_RNG_PSEUDO_XORWOW = 0
end

function miopenCreateDropoutDescriptor(dropoutDesc)
    ccall((:miopenCreateDropoutDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenDropoutDescriptor_t},), dropoutDesc)
end

function miopenDestroyDropoutDescriptor(dropoutDesc)
    ccall((:miopenDestroyDropoutDescriptor, libMIOpen_path), miopenStatus_t, (miopenDropoutDescriptor_t,), dropoutDesc)
end

function miopenDropoutGetReserveSpaceSize(xDesc, reserveSpaceSizeInBytes)
    ccall((:miopenDropoutGetReserveSpaceSize, libMIOpen_path), miopenStatus_t, (miopenTensorDescriptor_t, Ptr{Csize_t}), xDesc, reserveSpaceSizeInBytes)
end

function miopenDropoutGetStatesSize(handle, stateSizeInBytes)
    ccall((:miopenDropoutGetStatesSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, Ptr{Csize_t}), handle, stateSizeInBytes)
end

function miopenGetDropoutDescriptor(dropoutDesc, handle, dropout, states, seed, use_mask, state_evo, rng_mode)
    ccall((:miopenGetDropoutDescriptor, libMIOpen_path), miopenStatus_t, (miopenDropoutDescriptor_t, miopenHandle_t, Ptr{Cfloat}, Ptr{Ptr{Cvoid}}, Ptr{Culonglong}, Ptr{Bool}, Ptr{Bool}, Ptr{miopenRNGType_t}), dropoutDesc, handle, dropout, states, seed, use_mask, state_evo, rng_mode)
end

function miopenRestoreDropoutDescriptor(dropoutDesc, handle, dropout, states, stateSizeInBytes, seed, use_mask, state_evo, rng_mode)
    ccall((:miopenRestoreDropoutDescriptor, libMIOpen_path), miopenStatus_t, (miopenDropoutDescriptor_t, miopenHandle_t, Cfloat, Ptr{Cvoid}, Csize_t, Culonglong, Bool, Bool, miopenRNGType_t), dropoutDesc, handle, dropout, states, stateSizeInBytes, seed, use_mask, state_evo, rng_mode)
end

function miopenSetDropoutDescriptor(dropoutDesc, handle, dropout, states, stateSizeInBytes, seed, use_mask, state_evo, rng_mode)
    ccall((:miopenSetDropoutDescriptor, libMIOpen_path), miopenStatus_t, (miopenDropoutDescriptor_t, miopenHandle_t, Cfloat, Ptr{Cvoid}, Csize_t, Culonglong, Bool, Bool, miopenRNGType_t), dropoutDesc, handle, dropout, states, stateSizeInBytes, seed, use_mask, state_evo, rng_mode)
end

function miopenDropoutForward(handle, dropoutDesc, noise_shape, xDesc, x, yDesc, y, reserveSpace, reserveSpaceSizeInBytes)
    ccall((:miopenDropoutForward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenDropoutDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, dropoutDesc, noise_shape, xDesc, x, yDesc, y, reserveSpace, reserveSpaceSizeInBytes)
end

function miopenDropoutBackward(handle, dropoutDesc, noise_shape, dyDesc, dy, dxDesc, dx, reserveSpace, reserveSpaceSizeInBytes)
    ccall((:miopenDropoutBackward, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenDropoutDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, Csize_t), handle, dropoutDesc, noise_shape, dyDesc, dy, dxDesc, dx, reserveSpace, reserveSpaceSizeInBytes)
end

function miopenCreateReduceTensorDescriptor(reduceTensorDesc)
    ccall((:miopenCreateReduceTensorDescriptor, libMIOpen_path), miopenStatus_t, (Ptr{miopenReduceTensorDescriptor_t},), reduceTensorDesc)
end

function miopenDestroyReduceTensorDescriptor(reduceTensorDesc)
    ccall((:miopenDestroyReduceTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenReduceTensorDescriptor_t,), reduceTensorDesc)
end

function miopenSetReduceTensorDescriptor(reduceTensorDesc, reduceTensorOp, reduceTensorCompType, reduceTensorNanOpt, reduceTensorIndices, reduceTensorIndicesType)
    ccall((:miopenSetReduceTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenReduceTensorDescriptor_t, miopenReduceTensorOp_t, miopenDataType_t, miopenNanPropagation_t, miopenReduceTensorIndices_t, miopenIndicesType_t), reduceTensorDesc, reduceTensorOp, reduceTensorCompType, reduceTensorNanOpt, reduceTensorIndices, reduceTensorIndicesType)
end

function miopenGetReduceTensorDescriptor(reduceTensorDesc, reduceTensorOp, reduceTensorCompType, reduceTensorNanOpt, reduceTensorIndices, reduceTensorIndicesType)
    ccall((:miopenGetReduceTensorDescriptor, libMIOpen_path), miopenStatus_t, (miopenReduceTensorDescriptor_t, Ptr{miopenReduceTensorOp_t}, Ptr{miopenDataType_t}, Ptr{miopenNanPropagation_t}, Ptr{miopenReduceTensorIndices_t}, Ptr{miopenIndicesType_t}), reduceTensorDesc, reduceTensorOp, reduceTensorCompType, reduceTensorNanOpt, reduceTensorIndices, reduceTensorIndicesType)
end

function miopenGetReductionIndicesSize(handle, reduceTensorDesc, aDesc, cDesc, sizeInBytes)
    ccall((:miopenGetReductionIndicesSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenReduceTensorDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, reduceTensorDesc, aDesc, cDesc, sizeInBytes)
end

function miopenGetReductionWorkspaceSize(handle, reduceTensorDesc, aDesc, cDesc, sizeInBytes)
    ccall((:miopenGetReductionWorkspaceSize, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenReduceTensorDescriptor_t, miopenTensorDescriptor_t, miopenTensorDescriptor_t, Ptr{Csize_t}), handle, reduceTensorDesc, aDesc, cDesc, sizeInBytes)
end

function miopenReduceTensor(handle, reduceTensorDesc, indices, indicesSizeInBytes, workspace, workspaceSizeInBytes, alpha, aDesc, A, beta, cDesc, C)
    ccall((:miopenReduceTensor, libMIOpen_path), miopenStatus_t, (miopenHandle_t, miopenReduceTensorDescriptor_t, Ptr{Cvoid}, Csize_t, Ptr{Cvoid}, Csize_t, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}, Ptr{Cvoid}, miopenTensorDescriptor_t, Ptr{Cvoid}), handle, reduceTensorDesc, indices, indicesSizeInBytes, workspace, workspaceSizeInBytes, alpha, aDesc, A, beta, cDesc, C)
end

const MIOPEN_BACKEND_OPENCL = 0

const MIOPEN_BACKEND_HIP = 1

const MIOPEN_MODE_NOGPU = 0

const MIOPEN_USE_MIOPENTENSILE = 0

const MIOPEN_USE_MIOPENGEMM = 0

const MIOPEN_USE_ROCBLAS = 1

const MIOPEN_BUILD_DEV = 0

const MIOPEN_GPU_SYNC = 0

const MIOPEN_ENABLE_SQLITE = 1

const MIOPEN_ENABLE_SQLITE_KERN_CACHE = 1

const MIOPEN_DEBUG_FIND_DB_CACHING = 1

const MIOPEN_USE_COMGR = 1

const MIOPEN_USE_HIPRTC = 0

const MIOPEN_USE_HIP_KERNELS = 1

const MIOPEN_DISABLE_USERDB = 0

const MIOPEN_EMBED_DB = 0

const BUILD_SHARED_LIBS = 1

const MIOPEN_DISABLE_SYSDB = 0

const MIOPEN_LOG_FUNC_TIME_ENABLE = 0

const MIOPEN_ENABLE_SQLITE_BACKOFF = 1

const MIOPEN_USE_MLIR = 0

const HIP_PACKAGE_VERSION_MAJOR = 5

const HIP_PACKAGE_VERSION_MINOR = 2

const HIP_PACKAGE_VERSION_PATCH = 0

const MIOPEN_AMD_COMGR_VERSION_MAJOR = 2

const MIOPEN_AMD_COMGR_VERSION_MINOR = 4

const MIOPEN_AMD_COMGR_VERSION_PATCH = 0

const MIOPEN_USE_RNE_BFLOAT16 = 1

const MIOPEN_DEFAULT_FIND_MODE = "DynamicHybrid"

const MIOPEN_AMDGCN_ASSEMBLER = "/workspace/destdir/llvm/bin/clang"

const MIOPEN_HIP_COMPILER = "/workspace/destdir/llvm/bin/rocm-clang++"

const MIOPEN_OFFLOADBUNDLER_BIN = "/workspace/destdir/llvm/bin/clang-offload-bundler"

const MIOPEN_CACHE_DIR = "~/.cache/miopen/"

const MIOPEN_USE_GEMM = (MIOPEN_USE_MIOPENTENSILE == 1) || ((MIOPEN_USE_MIOPENGEMM == 1) || (MIOPEN_USE_ROCBLAS == 1))

const MIOPEN_NDEBUG = 0

const MIOPEN_INSTALLABLE = (MIOPEN_NDEBUG == 1) && !(MIOPEN_BUILD_DEV == 1)

const MIOPEN_ALLOC_BUFFERS = 0

const HIP_PACKAGE_VERSION_FLAT = (HIP_PACKAGE_VERSION_MAJOR * Culonglong(1000) + HIP_PACKAGE_VERSION_MINOR) * 1000000 + HIP_PACKAGE_VERSION_PATCH

# Skipping MacroDefinition: MIOPEN_EXPORT __attribute__ ( ( visibility ( "default" ) ) )

# Skipping MacroDefinition: MIOPEN_NO_EXPORT __attribute__ ( ( visibility ( "hidden" ) ) )

# Skipping MacroDefinition: MIOPEN_DEPRECATED __attribute__ ( ( __deprecated__ ) )

# const MIOPEN_DEPRECATED_EXPORT = MIOPEN_EXPORT(MIOPEN_DEPRECATED)

# const MIOPEN_DEPRECATED_NO_EXPORT = MIOPEN_NO_EXPORT(MIOPEN_DEPRECATED)

const MIOPEN_API_VERSION_REDUCE_TENSOR = 1

const MIOPEN_VERSION_MAJOR = 2

const MIOPEN_VERSION_MINOR = 17

const MIOPEN_VERSION_PATCH = 0
