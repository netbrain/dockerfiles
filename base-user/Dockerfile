FROM debian:jessie

#DEPS
RUN apt-get update && apt-get install -y sudo locales locales-all

#LOCALE
ENV LANG en_US.UTF-8
ENV LC_ALL $LANG
RUN sudo update-locale LC_ALL=$LANG LANG=$LANG

#ADD NORMAL USER
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

#USER ENV
ENV HOME /home/docker
ENV TOOLS_PATH $HOME/tools
ENV DEV_PATH $HOME/dev
#ENV LANG en_US.UTF-8
#ENV LC_ALL en_US.UTF-8

RUN mkdir -p $TOOLS_PATH $DEV_PATH $HOME/bin
WORKDIR $TOOLS_PATH
