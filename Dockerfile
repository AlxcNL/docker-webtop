FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="AlxcNL"
ARG USER_UID=1000

# title
ENV TITLE="Ubuntu MATE Torcs Server"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/webtop-logo.png && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  add-apt-repository ppa:ubuntu-toolchain-r/ppa -y && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends -y \
    ayatana-indicator-application \
    firefox \
    mate-applets \
    mate-applet-brisk-menu \
    mate-terminal \
    nala \
    pluma \
    ubuntu-mate-artwork \
    ubuntu-mate-default-settings \
    ubuntu-mate-desktop \
    ubuntu-mate-icon-themes

# Install packages
RUN \
  nala install --no-install-recommends -y \
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

# Install libraries
RUN \
  nala install --no-install-recommends -y \
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
    libxxf86vm-dev \
    libgl1-mesa-dev \
    vorbis-tools \
    xautomation \
    zlib1g-dev
        
RUN \    
  echo "**** mate tweaks ****" && \
  rm -f \
    /etc/xdg/autostart/mate-power-manager.desktop \
    /etc/xdg/autostart/mate-screensaver.desktop && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# Add local files
COPY /root /

USER $USER_UID

# Install Torcs
RUN git clone https://github.com/fmirus/torcs-1.3.7.git /tmp/torcs

WORKDIR /tmp/torcs
RUN \
  sudo ./configure && \
  make && \
  sudo make install && \
  make datainstall

# Configure ports and volumes
EXPOSE 3000-3010
EXPOSE 3020
VOLUME /config