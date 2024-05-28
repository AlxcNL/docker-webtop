#!/usr/bin/env bash

image="jaboo/torcs-server:0.2"
action="load"
arch=$(uname -m)

[[ -z $1 ]] || action=$1

printf "%s image %s for %s\n" $action $image $arch

if [[ "$arch" -eq "x86_64" ]]; then
    docker buildx build --no-cache "--${action}" --build-arg PLATFORM=amd64 -t $image -f Dockerfile .
else
    docker buildx build --no-cache "--${action}" --build-arg PLATFORM=arm64 -t $image -f Dockerfile.aarch64 .
fi
