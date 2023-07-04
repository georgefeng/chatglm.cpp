FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get -y install git cmake g++ python3-dev python3-pip libatlas-base-dev libopenblas-dev

# Clone the repository and its submodules
RUN git clone --recursive https://github.com/li-plus/chatglm.cpp.git

WORKDIR /chatglm.cpp

# Build the project with CPU acceleration
RUN cmake -B build && \
    cmake --build build -j

CMD ["./build/bin/main -m chatglm2-ggml.bin -p 你好"]
