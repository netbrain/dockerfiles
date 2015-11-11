FROM netbrain/base-user

ENV VIM_HOME=$TOOLS_PATH/vim

ENV TERM xterm-256color

RUN sudo apt-get -y install git build-essential libncurses5-dev python-dev

RUN ( git clone https://github.com/vim/vim $VIM_HOME && \
	cd $VIM_HOME && ./configure \
            --prefix=$VIM_HOME \
            --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-cscope \
            && make && make install )

ENV PATH=$PATH:$VIM_HOME/bin

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ADD .vimrc $HOME/.vimrc

RUN vim -i NONE -c VundleInstall -c GoInstallBinaries -c quitall

RUN (sudo apt-get -y install cmake exuberant-ctags && cd $HOME/.vim/bundle/YouCompleteMe && ./install.py)

RUN (echo "let g:vic = 1" | cat - $HOME/.vimrc > /tmp/out && mv /tmp/out $HOME/.vimrc)

WORKDIR $HOME


