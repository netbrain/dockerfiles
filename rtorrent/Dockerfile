FROM debian:jessie

ENV PACKAGES "git build-essential libncurses5-dev libcurl4-openssl-dev automake libtool libcppunit-dev wget zlib1g-dev pkg-config libssl-dev"

RUN apt-get update 
RUN apt-get -y install $PACKAGES

WORKDIR /usr/src

ENV LTV=0.13.6
ENV RTV=0.9.6
ENV LIBTORRENT=libtorrent-$LTV
ENV RTORRENT=rtorrent-$RTV

RUN wget http://rtorrent.net/downloads/$LIBTORRENT.tar.gz
RUN tar xzvf $LIBTORRENT.tar.gz
WORKDIR $LIBTORRENT
RUN ./configure --with-posix-fallocate --disable-shared --enable-static 
RUN make
RUN make install

WORKDIR /usr/src
RUN wget http://rtorrent.net/downloads/$RTORRENT.tar.gz
RUN tar xzvf $RTORRENT.tar.gz
WORKDIR $RTORRENT
RUN ./configure  --disable-shared --enable-static
RUN make
RUN make install

RUN apt-get remove -y $PACKAGES
RUN apt-get install -y libcurl3
RUN apt-get autoremove -y     

WORKDIR /root
ADD rtorrent.rc .rtorrent.rc
RUN mkdir sessions torrents watch

ENV TERM linux
CMD rtorrent
