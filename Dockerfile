# syntax=docker/dockerfile:1

FROM ubuntu:noble
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

LABEL authors="vaskozlov"

RUN apt-get update
RUN apt install -y git
RUN apt install -y gcc-14 g++-14
RUN apt install -y libstdc++-14-dev
RUN apt install -y clang-18
RUN apt install -y pkg-config
RUN apt install -y libc++abi-dev libc++-dev
RUN apt install -y clang-tidy-18
RUN apt install -y cmake
RUN apt install -y ninja-build
RUN apt install -y gdb
RUN apt install -y lldb
RUN apt install -y zip unzip
RUN apt install -y curl
RUN apt install -y catch2
RUN apt install -y libfmt-dev
RUN apt install -y libcxxopts-dev
RUN apt install -y libbenchmark-dev

RUN git clone https://github.com/llvm/llvm-project.git
RUN cmake -S /llvm-project/llvm -B /llvm-build -G Ninja -DLLVM_ENABLE_PROJECTS='clang;compiler-rt' -DLLVM_ENABLE_RUNTIMES='all' -DLLVM_TARGETS_TO_BUILD='AArch64;X86' -DLLVM_INCLUDE_TESTS=OFF -DLIBCXX_INSTALL_MODULES=ON -DCMAKE_C_COMPILER=/usr/bin/clang-18 -DCMAKE_CXX_COMPILER=/usr/bin/clang++-18 -DCMAKE_BUILD_TYPE=Release
RUN cd /llvm-build && ninja install all

ENV CC gcc-14
ENV CXX g++-14

ENTRYPOINT ["top", "-b"]