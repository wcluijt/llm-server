#!/bin/sh

CURRENT_SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P);
cd $CURRENT_SCRIPT_DIR;

sudo docker compose up -d;
