# syntax=docker/dockerfile:1

FROM --platform=${BUILDPLATFORM:-linux/amd64} ubuntu:noble as builder
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

ENV CC gcc-14
ENV CXX g++-14

ENTRYPOINT ["top", "-b"]