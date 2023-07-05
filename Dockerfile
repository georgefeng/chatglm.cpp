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


# CLI mode
# ENTRYPOINT ["build/bin/main","-m", "chatglm2-ggml.bin"]
# CMD ["-m", "chatglm2-ggml.bin", "-p", "你好"]

# Web mode
RUN pip install 

ENTRYPOINT ["python3", "examples/web_demo.py", "-m", "chatglm2-ggml.bin"]

CMD ["-m", "chatglm2-ggml.bin"]
# Expose port for web demo
EXPOSE 7860
