# docker run -it --rm \
# --privilged \
# -e DISPLAY=$DISPLAY \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# netbrain/scrcpy 
# adb pair ip:port key / scrcpy --tcpip=ip:port

FROM alpine

VOLUME /home/user

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache android-tools scrcpy mesa-dri-gallium virtualgl \
	&& adduser --disabled-password user \
	&& chown user.user /home/user

USER user
