FROM node

RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y --force-yes install deb-multimedia-keyring ffmpeg
RUN npm -g install castnow

ENTRYPOINT ["castnow"]
CMD ["--help"]
