using AMDGPU

kernel(x) = @rocprintf "Value: %d\n" x
# kernel() = @rocprint "Hello World!"

function main()
    @roc kernel(42)
    AMDGPU.synchronize(; stop_hostcalls=true)
    # @roc kernel()
    # AMDGPU.synchronize(; stop_hostcalls=true)
    return
end
main()
