#!/usr/bin/env bash

if [[ "$(uname -m)" -eq "x86_64" ]]; then
    docker-buildx build $1 --load --build-arg PLATFORM=amd64 -t jaboo/torcs-server:0.1 -f Dockerfile .
else
    docker-buildx build $1 --load --build-arg PLATFORM=arm64 -t jaboo/torcs-server:0.1 -f Dockerfile.aarch64 .
fi