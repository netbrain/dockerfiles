# docker run -it --restart=always 
#	-v /factorio/saves:/factorio/saves 
#	-v /factorio/mods:/factorio/mods 
#	-p 34197:34197
# 	netbrain/factorio

FROM debian:jessie

RUN apt-get update && apt-get install -y curl
RUN curl -L http://www.factorio.com/get-download/0.12.29/headless/linux64 | tar xz
WORKDIR /factorio/bin/x64
CMD sh -c "./factorio --create default && ./factorio --start-server default"
