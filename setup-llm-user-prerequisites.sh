#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

### Go binaries
echo "export PATH=/usr/local/go/bin:\$PATH;" >> /home/llm/.profile;

### AMD / ROCm binaries
echo "export PATH=/opt/rocm/hcc/bin:/opt/rocm/hip/bin:/opt/rocm/bin:/opt/rocm/hcc/bin:\$PATH;" >> /home/llm/.profile;

### Nvidia / CUDA binaries
echo "export PATH=/usr/local/cuda-12/bin:\$PATH;" >> /home/llm/.profile;

#source ~/.profile;

