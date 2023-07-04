FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get -y install git cmake g++ python3-dev python3-pip libatlas-base-dev libopenblas-dev

# Clone the repository and its submodules
RUN git clone --recursive https://github.com/li-plus/chatglm.cpp.git

WORKDIR /chatglm.cpp

# Quantize the model
RUN python3 convert.py -i THUDM/chatglm-6b -t q4_0 -o chatglm-ggml.bin

# Build the project with CPU acceleration
RUN cmake -B build && \
    cmake --build build -j

# Expose port for web demo
EXPOSE 8080

# Install Python package and create a symlink to the main executable file
RUN pip3 install .

CMD ["cli-chat", "-m", "chatglm-ggml.bin", "-i"]
