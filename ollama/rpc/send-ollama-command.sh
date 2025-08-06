#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;
cd ./ollama-rpc-GH-10844;

### Provide a comma-separated list of `host:port` pairs:  OLLAMA_RPC_SERVERS="127.0.0.1:50052,192.168.0.69:50053" ollama serve
touch ../OLLAMA_RPC_SERVERS.txt;
OLLAMA_RPC_SERVERS=${OLLAMA_RPC_SERVERS:-"$(cat ../OLLAMA_RPC_SERVERS.txt)"}

OLLAMA_RPC_SERVERS=$OLLAMA_RPC_SERVERS \
OLLAMA_LIBRARY_PATH=./build/lib/ollama:/usr/local/cuda-12:/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin \
LD_LIBRARY_PATH=./build/lib/ollama:/usr/local/cuda-12:/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin \
NVIDIA_DRIVER_CAPABILITIES=compute,utility \
NVIDIA_VISIBLE_DEVICES=all \
OLLAMA_HOST=0.0.0.0:11434 \
go run . "$@";

