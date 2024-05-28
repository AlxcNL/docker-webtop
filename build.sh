#!/usr/bin/env bash
# Author: J.A.Boogaard@hr.nl

repo="jaboo"
image_name="torcs-server"
version="0.2"
arch=$(uname -m)
action="load"

if [[ -n $1 ]]; then
    action=$1
fi

function buildImage() {
    tag="${version}-${arch}"
    image="${repo}/${image_name}:${tag}"

    printf "Build and %s image %s for %s\n" $action $image $arch;
    cmd="docker buildx build --no-cache --${action}"

    if [[ $arch == "x86_64" ]]; then
        cmd="${cmd} --build-arg PLATFORM=amd64 -t $image -f Dockerfile ."
    else
        cmd="${cmd}  --build-arg PLATFORM=arm64 -t $image -f Dockerfile.aarch64 ."
    fi

    echo $cmd
    eval $cmd

}

buildImage

if [[ $action == "push" ]]; then
    version="latest"
    buildImage    
fi

