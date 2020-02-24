#!/bin/bash
set -e
LATEST_VERSION=$(curl --silent https://api.github.com/repos/rcsoccersim/rcssserver/releases/latest | grep -Po '"tag_name": "\K.*?(?=")' | cut -d '-' -f 2)
podman build --build-arg VERSION=$LATEST_VERSION -t orangefoil/rcssserver:$LATEST_VERSION -t orangefoil/rcssserver:latest .
podman push orangefoil/rcssserver:$LATEST_VERSION docker://docker.io/orangefoil/rcssserver:$LATEST_VERSION
