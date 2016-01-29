set nocompatible		" be iMproved, required
filetype off			" required

" VUNDLE
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" NERDTREE
Plugin 'scrooloose/nerdtree'

" SYNTASTIC
Plugin 'scrooloose/syntastic'

" VIM-GO
Plugin 'fatih/vim-go'

" AIRLINE
Plugin 'bling/vim-airline'

" CTRLP
Plugin 'ctrlpvim/ctrlp.vim'

" TAGBAR
Plugin 'majutsushi/tagbar'

" YOUCOMPLETEME
Plugin 'Valloric/YouCompleteMe'

" BUFTABLINE
Plugin 'ap/vim-buftabline'

" COLORSCHEMES
" Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
if exists("g:vic")
set mouse=a			" enable mouse	
syntax on			" enable syntax higlighting
let mapleader = ","		" set leader to ,
set hlsearch			" show matches during searching
set backspace=2			" set normal backspace
set background=dark		" set dark backround
let g:solarized_termtrans = 1	" transparent background color for solarized colorscheme 
colorscheme solarized		" set colorscheme
set encoding=utf-8

autocmd VimEnter * NERDTree
autocmd VimEnter * TagbarOpen
autocmd VimEnter * wincmd l

" NERDTREE
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <Leader>n :NERDTreeToggle<CR>

" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" VIM-GO
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

" shows errors for the fmt command
let g:go_fmt_fail_silently = 0

" auto fmt on save:
let g:go_fmt_autosave = 1

" Disable opening browser after posting your snippet to play.golang.org:
let g:go_play_open_browser = 0

" TAGBAR
nmap <Leader>m :TagbarToggle<CR>

" BUFTABLINE
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
endif
