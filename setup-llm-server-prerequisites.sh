#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

### Install Git
sudo apt-get update;
sudo apt-get install -y git;

### Install Docker CE
sudo apt-get update;
sudo apt-get install -y ca-certificates curl;
sudo install -m 0755 -d /etc/apt/keyrings;
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc;
sudo chmod a+r /etc/apt/keyrings/docker.asc;
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt-get update;
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;

### Install AMD Drivers
sudo apt-get update;
sudo apt-get install -y linux-headers-$(uname -r);
sudo apt-get install -y wget;
wget https://repo.radeon.com/amdgpu-install/6.4.2/ubuntu/jammy/amdgpu-install_6.4.60402-1_all.deb;
sudo apt-get install -y ./amdgpu-install_6.4.60402-1_all.deb;
sudo apt-get update;
sudo apt-get install -y python3-setuptools python3-wheel;
#sudo usermod -aG render,video $LOGNAME;
sudo apt-get install -y rocm;
sudo apt-get install -y amdgpu-dkms;
sudo amdgpu-install -y --usecase=graphics,rocm;

### Install Nvidia Drivers
sudo apt-get update;
sudo apt-get install -y linux-headers-$(uname -r);
sudo apt-get install -y nvidia-driver firmware-misc-nonfree;
sudo apt-get install -y wget;
wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb;
sudo dpkg -i cuda-keyring_1.1-1_all.deb;
sudo apt-get update;
sudo apt-get install -y cuda-toolkit-12-9;
sudo apt-get install -y cuda-drivers;
sudo apt-get install -y nvidia-container-toolkit;
sudo nvidia-ctk runtime configure --runtime=docker;
sudo systemctl restart docker;

#sudo systemctl reboot

