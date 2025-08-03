#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

sudo apt-get update;
sudo apt-get install -y inxi;

sudo inxi -Fxz > server-specs.txt;

