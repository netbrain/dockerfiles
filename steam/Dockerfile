##!/bin/bash
#set -e
#
#DATA_CONTAINER="data-steam"
#DOCKER_IMAGE="netbrain/steam"
#
#
#if  ! docker inspect $DATA_CONTAINER >& /dev/null;  then
#	docker create \
#		-v /home/steam \
#		--name $DATA_CONTAINER \
#		busybox
#	docker run --volumes-from $DATA_CONTAINER busybox chown -R 1000:1000 /home/steam
#fi
#
#docker run -it --rm \
#        -e DISPLAY=unix$DISPLAY \
#	--privileged \
#	--net=host \
#	-v /etc/localtime:/etc/localtime:ro \
#        -v /tmp/.X11-unix:/tmp/.X11-unix \
#        -v $HOME/.Xauthority:/home/steam/.Xauthority \
#	-v /dev/shm:/dev/shm \
#	-v /etc/machine-id:/etc/machine-id \
#	-v /run/user/$UID/pulse/native:/tmp/pulse \
#	-v /dev/dri:/dev/dri \
#	--name steam \
#	--volumes-from $DATA_CONTAINER \
#        $DOCKER_IMAGE $@
#

FROM ubuntu

RUN echo 'deb [arch=amd64,i386] http://repo.steampowered.com/steam precise steam' > /etc/apt/sources.list.d/steam-inst.list && dpkg --add-architecture i386
RUN apt-get update && apt-get install -yq --no-install-recommends --force-yes sudo libgl1-mesa-dri steam pulseaudio \
    && rm -rf /etc/apt/sources.list.d/steam-inst.list \
    && apt-get update \
    && apt-get install -yq libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386 libnss3:i386 dbus:i386 \
    && apt-get clean

RUN echo 'steam ALL = NOPASSWD: ALL' > /etc/sudoers.d/steam
RUN chmod 0440 /etc/sudoers.d/steam
RUN adduser --disabled-password steam --gecos "Steam"

USER steam
ENV HOME /home/steam
VOLUME /home/steam
ENV PULSE_SERVER unix:/tmp/pulse

CMD sudo /etc/init.d/dbus start && steam
