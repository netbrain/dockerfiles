FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install xorg i3 xserver-xorg-input-kbd 
#RUN apt-get -y install xserver-xorg-core 
#RUN bash -c "apt-get -y install xserver-xorg-video-{intel,modesetting,fbdev,vesa}"

ADD 10-input.conf /etc/X11/xorg.conf.d/

ENTRYPOINT bash
#docker run --rm --name xorg -it --group-add audio --group-add video --group-add plugdev --device /dev/tty10 --device /dev/input/mice --device /dev/input --device /dev/dri  netbrain/xorg
