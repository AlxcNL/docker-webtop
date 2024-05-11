#!/usr/bin/env bash

docker-buildx build --no-cache --load --build-arg PLATFORM=arm64 -t torcs-server:0.1 -f Dockerfile.aarch64 .
