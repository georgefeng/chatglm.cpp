FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update
RUN apt-get -y install wget git cmake g++ python3-dev python3-pip libatlas-base-dev 

# Clone the repository and its submodules
RUN git clone --recursive https://github.com/li-plus/chatglm.cpp.git

WORKDIR /chatglm.cpp

RUN wget -q -O chatglm2-ggml.bin https://huggingface.co/georgeff/chatglm2-cpp/resolve/main/chatglm2-ggml.bin

# Build the project with CPU acceleration
RUN cmake -B build && \
    cmake --build build -j

ENTRYPOINT ["build/bin/main"]
CMD ["-p", "你好"]
