FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential \
    clang \
    flex \
    bison \
    g++ \
    gawk \
    gcc-multilib \
    g++-multilib \
    gettext \
    git \
    libncurses5-dev \
    libssl-dev \
    python3 \
    rsync \
    unzip \
    wget \
    zlib1g-dev \
    file \
    make \
    curl \
    ca-certificates \
    nano \
    && apt clean

WORKDIR /workspace

CMD ["/bin/bash"]
