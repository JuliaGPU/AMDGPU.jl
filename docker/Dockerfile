FROM rocm/dev-ubuntu-20.04:latest

# Install ROCm dependencies
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl libnuma-dev gnupg &&\
    curl -sL http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | apt-key add - &&\
    printf "deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main" | tee /etc/apt/sources.list.d/rocm.list &&\
    apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libelf1 \
        rocm-dev \
        rocblas \
        rocsparse \
        rocalution \
        rocfft \
        rocrand \
        miopen-hip \
        ca-certificates \
        build-essential &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Install Julia
RUN curl -L https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.1-linux-x86_64.tar.gz > /tmp/julia-1.5.1.tar.gz &&\
    cd root &&\
    tar -xzvf /tmp/julia-1.5.1.tar.gz

# Install AMDGPU.jl
RUN /root/julia-1.5.1/bin/julia -E "using Pkg; Pkg.add(\"AMDGPU\"); Pkg.build(\"AMDGPU\")"

VOLUME ["/root/.julia"]
ENTRYPOINT ["/root/julia-1.5.1/bin/julia"]

