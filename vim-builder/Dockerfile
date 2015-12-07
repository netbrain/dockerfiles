FROM debian:jessie

ENV VIM_HOME=/usr/src/vim

RUN apt-get update && apt-get -y install git build-essential libncurses5-dev python-dev checkinstall libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev

RUN mkdir -p $VIM_HOME
WORKDIR $VIM_HOME
ADD entrypoint.sh /entrypoint.sh
CMD /entrypoint.sh
