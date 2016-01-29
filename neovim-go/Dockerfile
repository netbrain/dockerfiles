FROM netbrain/go

#install dependencies
RUN sudo apt-get update
RUN sudo apt-get install -y git build-essential cmake pkg-config libtool-bin automake curl unzip xsel exuberant-ctags python-pip

#clean cache
RUN sudo apt-get clean
RUN sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#download neovim
WORKDIR $TOOLS_PATH
RUN git clone https://github.com/neovim/neovim

#compile neovim
WORKDIR neovim
RUN make -j 4 CMAKE_BUILD_TYPE=Release
RUN sudo make install

#install python modules
RUN sudo pip install neovim

#create base config
ENV XDG_CONFIG_HOME $HOME/.config
RUN mkdir -p $XDG_CONFIG_HOME/nvim
ADD .vimrc $XDG_CONFIG_HOME/nvim/init.vim
ADD basic.vim $XDG_CONFIG_HOME/nvim/basic.vim
ADD plugins.vim $XDG_CONFIG_HOME/nvim/plugins.vim
ADD user.vim $XDG_CONFIG_HOME/nvim/user.vim

#create a nvim GOPATH for vim-go deps
#ENV NVIM_GOPATH $HOME/.nvim-go-deps
#RUN mkdir -p $NVIM_GOPATH

#Install plugins and go binaries
RUN curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim --headless -c "PlugInstall | qa"
RUN nvim --headless -c "GoInstallBinaries" -c "qa"

#done
WORKDIR $HOME
CMD nvim
