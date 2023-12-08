FROM debian:bookworm-slim
ARG WINE_VERSION=7.0.0.0~bookworm-1
ARG WINETRICKS_VERSION=20210206
ENV NVIDIA_VISIBLE_DEVICES \
  ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
  ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility
ENV WINEDEBUG ${WINEDEBUG:-fixme-all}

RUN dpkg --add-architecture i386 

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  sudo \
  wget \
  unzip \
  gnupg2 \
  procps \
  winbind \
  pulseaudio \
  ca-certificates \
  libxau6 libxau6:i386 \
  libxdmcp6 libxdmcp6:i386 \
  libxcb1 libxcb1:i386 \
  libxext6 libxext6:i386 \
  libx11-6 libx11-6:i386 \
  libglvnd0 libglvnd0:i386 \
  libgl1 libgl1:i386 \
  libglx0 libglx0:i386 \
  libegl1 libegl1:i386 \
  libgles2 libgles2:i386 \
  libgl1-mesa-glx libgl1-mesa-glx:i386 \
  libgl1-mesa-dri libgl1-mesa-dri:i386 && \
  wget -qO - http://dl.winehq.org/wine-builds/winehq.key | apt-key add - && \
  echo "deb https://dl.winehq.org/wine-builds/debian/ bookworm main" > \
  /etc/apt/sources.list.d/winehq.list && \ 
  sed -i '/^Types: deb/{:a; N; /\n$/!ba; s/Suites: \(.*\)/Suites: bullseye \1/}' /etc/apt/sources.list.d/debian.sources && \
  apt-get update && \
  apt-get -y install --install-recommends \
  winehq-stable=${WINE_VERSION} \
  wine-stable=${WINE_VERSION} \
  wine-stable-amd64=${WINE_VERSION} \
  wine-stable-i386=${WINE_VERSION} && \
  rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
  echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY pulse-client.conf /etc/pulse/client.conf

RUN \
  wget \
  https://raw.githubusercontent.com/Winetricks/winetricks/${WINETRICKS_VERSION}/src/winetricks \
  -O /usr/local/bin/winetricks && \
  chmod +x /usr/local/bin/winetricks

RUN adduser --disabled-password --gecos ''  user && \
  adduser user sudo && \
  echo '%SUDO ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user
