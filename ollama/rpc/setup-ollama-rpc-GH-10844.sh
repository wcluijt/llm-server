#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

### Retrieve Ollama and apply RPC Server patch
git clone https://github.com/ollama/ollama.git ollama-rpc-GH-10844;
cd ./ollama-rpc-GH-10844;
git checkout main;
git pull;
git branch rpc-GH-10844 4183bb0574a28b73276efef944107d0c45d79c95;
git checkout rpc-GH-10844;
git apply --3way ../GH-10844.patch;

#sudo docker build -t ollama:rpc-GH-10844 .;

### Install Go
curl -LO https://go.dev/dl/go1.24.5.linux-amd64.tar.gz;
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz;
echo "export PATH=\$PATH:/usr/local/go/bin;" >> ~/.profile;
source ~/.profile;
which go && go version;

### Install CMake
sudo apt-get update;
sudo apt-get install -y cmake;

### Build Ollama RPC Server
cmake -B build;
cmake --build build;

#go run . serve;
#go run . rpc;

