"General
" -------------------------------------------------------------------
try
	colorscheme solarized
	let g:solarized_termtrans = 1
catch
endtry

"Tabs
" -------------------------------------------------------------------
try
	unmap <leader>t<leader> 
catch
endtry

map <c-a-t> :tabnew<cr>
map <c-a-l> :tabnext<cr>
map <c-a-h> :tabprevious<cr>

"VIM-GO
" -------------------------------------------------------------------
autocmd BufWritePost,FileWritePost *.go execute 'GoMetaLinter'

"Run commands such as go run for the current file with <leader>r or go build
"and go test for the current package with <leader>b and <leader>t
"respectively. Display beautifully annotated source code to see which
"functions are covered with <leader>c.
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage)

"By default the mapping gd is enabled, which opens the target identifier in
"current buffer. You can also open the definition/declaration, in a new
"vertical, horizontal, or tab, for the word under your cursor:
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

"Open the relevant Godoc for the word under the cursor with <leader>gd or open
"it vertically with <leader>gv
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

"au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Show a list of interfaces which is implemented by the type under your cursor
" with <leader>s
au FileType go nmap <Leader>s <Plug>(go-implements)

"Show type info for the word under your cursor with <leader>i (useful if you have
"disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>i <Plug>(go-info)

"Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)

"Run :GoRun in a new tab, horizontal split or vertical split terminal
au FileType go nmap <Leader>rt <Plug>(go-run-tab)
au FileType go nmap <Leader>rs <Plug>(go-run-split)
au FileType go nmap <Leader>rv <Plug>(go-run-vertical)

"Quickly navigate through these location lists with :lne for 
"next error and :lp for previous. You can also bind these to keys, for example:
map <C-n> :lne<CR>
map <C-m> :lp<CR>

" By default new terminals are opened in a vertical split. To change it
let g:go_term_mode = "split"                   "or set to tab

"By default when :GoInstallBinaries is called, the binaries are installed to
"$GOBIN or $GOPATH/bin. To change it:
let g:go_bin_path = "/home/docker/.neovim-go-deps"

"Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

" TAGBAR
" -------------------------------------------------------------------
nmap <Leader>tb :TagbarToggle<CR>

" UltiSnips
" -------------------------------------------------------------------

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
