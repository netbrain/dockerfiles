FROM netbrain/base-dev

RUN sudo apt-get update
RUN sudo apt-get -y install libncurses5-dev python-dev \
    ruby-dev git python2.7 build-essential libncurses5-dev

WORKDIR $TOOLS_PATH

RUN git clone https://go.googlesource.com/go
RUN cp -R go go1.4
RUN (cd go1.4 && git checkout go1.4 && cd src && ./all.bash)

ENV GOROOT_BOOTSTRAP=$TOOLS_PATH/go1.4

RUN (cd go && git checkout go1.5.3 && cd src && ./all.bash )

ENV GOROOT=$TOOLS_PATH/go
ENV GOPATH=$HOME/dev/go
ENV PATH=$PATH:$GOROOT/bin
ENV PATH=$PATH:$GOPATH/bin

WORKDIR $HOME
