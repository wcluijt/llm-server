#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

### Retrieve Ollama and apply RPC Server patch
git clone https://github.com/ollama/ollama.git ollama-rpc-GH-10844;
cd ./ollama-rpc-GH-10844;
git checkout main;
git pull;
#git branch rpc-GH-10844 4183bb0574a28b73276efef944107d0c45d79c95;
git branch rpc-GH-10844 2c776f07805022221e7640a643777818528d0a27;
git checkout rpc-GH-10844;
git apply --3way ../GH-10844.patch;

### Go binaries
export PATH=/usr/local/go/bin:$PATH;

### AMD / ROCm binaries
export PATH=/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin:/opt/rocm/hcc/bin:$PATH;

### Nvidia / CUDA binaries
export PATH=/usr/local/cuda-12/bin:$PATH;

### Install G++
which g++ || ( \
sudo apt-get update; \
sudo apt-get install -y g++; \
);

### Install Go
which go || ( \
curl -LO https://go.dev/dl/go1.24.5.linux-amd64.tar.gz; \
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz; \
export PATH=/usr/local/go/bin:$PATH; \
which go && go version; \
);

### Install CMake
which cmake || ( \
sudo apt-get update; \
sudo apt-get install -y cmake; \
);

### Build Ollama RPC Server
cmake -B build;
cmake --build build;

#go run . serve;
#go run . rpc;

### Setup Dockerfile for Ollama RPC Server
cp ./Dockerfile ./Dockerfile.rpc;
sed -i '/CMD \["serve"\]/s/serve/rpc/' ./Dockerfile.rpc;
sed -i 's/11434/50052/g' ./Dockerfile.rpc;

### Build Docker Ollama RPC Server - CPU
#sudo docker build -t ollama:rpc-GH-10844-serve-cpu --build-arg FLAVOR=cpu -f ./Dockerfile .;
#sudo docker build -t ollama:rpc-GH-10844-rpc-cpu --build-arg FLAVOR=cpu -f ./Dockerfile.rpc .;

### Build Docker Ollama RPC Server - CUDA
#sudo docker build -t ollama:rpc-GH-10844-serve-cuda --build-arg FLAVOR=cuda-12 -f ./Dockerfile .;
#sudo docker build -t ollama:rpc-GH-10844-rpc-cuda --build-arg FLAVOR=cuda-12 -f ./Dockerfile.rpc .;

### Build Docker Ollama RPC Server - ROCm
#sudo docker build -t ollama:rpc-GH-10844-serve-rocm --build-arg FLAVOR=rocm -f ./Dockerfile .;
#sudo docker build -t ollama:rpc-GH-10844-rpc-rocm --build-arg FLAVOR=rocm -f ./Dockerfile.rpc .;

### Build Docker Ollama RPC Server - Default
#sudo docker build -t ollama:rpc-GH-10844-serve -f ./Dockerfile .;
#sudo docker build -t ollama:rpc-GH-10844-rpc -f ./Dockerfile.rpc .;
