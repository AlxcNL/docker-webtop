#!/usr/bin/env bash

export CFLAGS='-fPIC'
export CPPFLAGS='\$CFLAGS'
export CXXFLAGS='\$CFLAGS'

sudo apt-get update && \
sudo apt-get install -y libxxf86vm-dev \
    sudo \
    nala

echo "Install packages"
sudo nala install --no-install-recommends -y \
    build-essential \
    cmake \
    gcc \
    git \
    iputils-ping \
    net-tools \
    python-is-python3 \
    python3-full \
    python3-pip \
    unzip \
    zip

echo "Install libraries"
sudo nala install --no-install-recommends -y \
    freeglut3-dev \
    libalut-dev \
    libegl1-mesa-dev \
    libglib2.0-dev \
    libglu1-mesa-dev \
    libopenal1 \
    libopenal-dev \
    libpng-dev \
    libxi-dev \
    libxmu-dev \
    libxrandr-dev \
    libxrender-dev \
    libxrender1 \
    libopenal1 \
    libplib-dev \
    libpng-dev \
    libvorbis-dev \
    libxi-dev \
    libxmu-dev \
    libxrandr-dev \
    libxrender-dev \
    libxrender1 \
    libgl1-mesa-dev \
    vorbis-tools \
    xautomation \
    zlib1g-dev

echo "Install Torcs"
git clone https://github.com/fmirus/torcs-1.3.7.git $HOME/torcs

sudo $HOME/torcs/configure
(cd $HOME/torcs; make)
(cd $HOME/torcs; sudo make install)
(cd $HOME/torcs; make datainstall)