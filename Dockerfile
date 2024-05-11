FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

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

# NEW
RUN \
  nala install --no-install-recommends -y \
    ansible \
    build-essential \
    cmake \
    gcc \
    iputils-ping \
    net-tools \
    python-is-python3 \
    python3-full \
    python3-pip && \
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

# add local files
COPY /root /

# NEW
RUN \
  chmod u+x /tmp/install/playbooks/playbook-*.yaml && \
  /tmp/install/playbooks/playbook-torcs.yaml


# ports and volumes
EXPOSE 3020
VOLUME /config