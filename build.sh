#!/usr/bin/env bash
# Author: J.A.Boogaard@hr.nl

repo="jaboo"
image_name="torcs-server"
tag="0.2"
arch=$(uname -m)

if [[ -n $1 ]]; then
    action=$1
else
    action="load"
fi

function buildImage() {
    printf "Build and %s image %s for %s\n" $action $image $arch;

    if [[ "$arch" -eq "x86_64" ]]; then
        tag="${tag}-${arch}"
        image="${repo}/${image_name}:${tag}"
        cmd="docker buildx build --${action} --build-arg PLATFORM=amd64 -t $image -f Dockerfile ."
    else
        cmd="docker buildx build --${action} --build-arg PLATFORM=arm64 -t $image -f Dockerfile.aarch64 ."
        image="${repo}/${image_name}:${tag}"
    fi

    echo $cmd
    eval $cmd

}

buildImage

if [[ $action -eq "push" ]]; then
    image="${repo}/${image_name}:latest"
    buildImage
fi
