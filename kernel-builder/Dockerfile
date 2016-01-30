# docker run -it --rm -v /usr/src:/usr/src netbrain/kernel-builder 4.4
FROM debian:jessie

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	git build-essential ncurses-dev kernel-package curl xz-utils \
	cpio

WORKDIR /usr/src
ADD ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
