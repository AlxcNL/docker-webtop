#!/usr/bin/env bash

action="load"
arg=""
dockerFile="Dockerfile"

if [[ -n $1 ]]; then
    if [[ $1 -eq "push" ]]; then
        action="$1"
    else
        arg="$1"
    fi

fi

if [ "$(uname -m)" = "x86_64" ]; then
    platform="amd64"
else
    platform="arm64"
    dockerFile="${dockerFile}.aarch64"
fi

cmd="$cmd docker-buildx build $arg --${action} --build-arg PLATFORM=${platform} -t jaboo/torcs-server:0.1 -f $dockerFile ."

echo $cmd
eval $cmd