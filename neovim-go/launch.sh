#!/bin/bash
NVIMF=${1/$GOPATH/.}
NVIMCD=$(dirname $NVIMF)

docker run -it --rm \
	-v $GOPATH:/home/docker/dev/go \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $PWD/plugins.vim:/home/docker/.config/nvim/plugins.vim \
	-v $PWD/user.vim:/home/docker/.config/nvim/user.vim \
	-v $PWD/basic.vim:/home/docker/.config/nvim/basic.vim \
	-e DISPLAY=unix$DISPLAY \
	-e NVIMF=$NVIMF \
	-e NVIMCD=$NVIMCD \
	netbrain/neovim-go sh -c "nvim -c \":cd \$GOPATH/\$NVIMCD\" \$GOPATH/\$NVIMF"
