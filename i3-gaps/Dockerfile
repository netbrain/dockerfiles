FROM netbrain/base-user

RUN sudo apt-get update && sudo apt-get install -y git build-essential libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev

RUN git clone https://www.github.com/Airblader/i3 i3-gaps
WORKDIR i3-gaps

RUN git checkout gaps && git pull
RUN make && sudo make install

RUN sudo apt-get install -y devscripts dpkg-dev reprepro ubuntu-dev-tools pbuilder
RUN sudo ln -s pbuilder-dist /usr/bin/pbuilder-sid-amd64
RUN sudo ln -s pbuilder-dist /usr/bin/pbuilder-sid-i386
CMD pbuilder-sid-amd64 create
