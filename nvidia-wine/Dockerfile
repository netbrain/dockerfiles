FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

ENV WINEDEBUG=fixme-all

RUN apt-get update \
    && apt-get install -y sudo wget software-properties-common gnupg2 winbind xvfb pulseaudio \
    && dpkg --add-architecture i386 \
    && wget -nc https://dl.winehq.org/wine-builds/winehq.key \
    && apt-key add winehq.key \
    && add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' \
    && apt-get update \
    && apt-get install -y winehq-devel winetricks \
    && apt-get clean -y \
    && apt-get autoremove -y

RUN adduser --disabled-password --gecos ''  user \
    && adduser user sudo \
    && echo '%SUDO ALL=(ALL) NOPASSWD:ALL' >> \
    /etc/sudoers

USER user
WORKDIR /home/user

RUN winetricks --unattended msxml6 \
    && winetricks --unattended corefonts \
    && wget -P /tmp https://github.com/madewokherd/wine-mono/releases/download/wine-mono-6.1.2/wine-mono-6.1.2-x86.msi \
    && wine msiexec /i /tmp/wine-mono-6.1.2-x86.msi \
    && wget -P /tmp http://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86.msi \
    && wget -P /tmp http://dl.winehq.org/wine/wine-gecko/2.47.2/wine-gecko-2.47.2-x86_64.msi \
    && wine msiexec /i /tmp/wine-gecko-2.47.2-x86.msi \
    && wine msiexec /i /tmp/wine-gecko-2.47.2-x86_64.msi \
    && rm -rf /tmp/*.msi

COPY pulse-client.conf /etc/pulse/client.conf
