# docker buildx build --output type=docker,name=test .

FROM --platform=linux/amd64 debian:bullseye-slim as wine-src

RUN \
	apt-get update && \
	apt-get -y install \
		git && \
	rm -rf /var/lib/apt/lists/*

RUN \
	git clone \
	--depth 1 \
	-b wine-7.0 \
	https://github.com/wine-mirror/wine \
	/usr/src/wine

FROM --platform=linux/amd64 wine-src as wine64-builder
ENV CFLAGS="-march=native -O3 -pipe -fstack-protector-strong"
COPY deps /tmp/deps

RUN \
	apt-get update && \
	cat /tmp/deps | xargs apt-get -y install && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/wine64

RUN \
	../wine/configure \
	--prefix=/usr/src/wine64-build \
	--enable-win64 && \
	make -j $(nproc) && \
	make install

FROM --platform=linux/i386 debian:bullseye-slim as wine32-tools-builder
ENV CFLAGS="-march=native -O3 -pipe -fstack-protector-strong"
COPY deps /tmp/deps

RUN \
	apt-get update && \
	cat /tmp/deps | xargs apt-get -y install && \
	rm -rf /var/lib/apt/lists/*

COPY --from=wine-src /usr/src/wine /usr/src/wine

WORKDIR /usr/src/wine32-tools

RUN \
	../wine/configure && \
	make -j $(nproc)

FROM --platform=linux/i386 wine32-tools-builder as wine32-builder

COPY --from=wine64-builder /usr/src/wine64 /usr/src/wine64

WORKDIR /usr/src/wine32

RUN \
	../wine/configure \
	--prefix=/usr/src/wine32-build \
	--with-wine-tools=../wine32-tools \
	--with-wine64=../wine64 && \
	make -j $(nproc) && \
	make install

FROM --platform=linux/amd64 debian:bullseye-slim as final	

ENV WINEDEBUG=fixme-all

COPY runtime-deps /tmp/runtime-deps

RUN \
  dpkg --add-architecture i386 && \
  apt-get update && \
  cat /tmp/runtime-deps | xargs apt-get -y install && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin

RUN \
	wget \
	https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
	chmod +x winetricks

COPY --from=wine32-builder /usr/src/wine32-build /usr/local
COPY --from=wine64-builder /usr/src/wine64-build /usr/local

WORKDIR /tmp

COPY pulse-client.conf /etc/pulse/client.conf
