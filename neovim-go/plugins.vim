call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'
"
" " Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

Plug 'altercation/vim-colors-solarized'

Plug 'fatih/vim-go'

Plug 'majutsushi/tagbar'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'garyburd/go-explorer'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'Raimondi/delimitMate'

Plug 'janko-m/vim-test'

" Add plugins to &runtimepath
 call plug#end()
