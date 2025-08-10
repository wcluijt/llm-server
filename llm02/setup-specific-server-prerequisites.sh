#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

### Allow AMD Radeon GPU drivers
sudo apt-get purge -y '*nvidia*';
sudo apt-get update;
sudo apt-get install -y firmware-misc-nonfree firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all;
sudo rm -rf /etc/modprobe.d/blacklist-radeon.conf;
sudo modprobe radeon;

