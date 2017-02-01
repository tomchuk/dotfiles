execute pathogen#infect()
" Use the Solarized Dark theme
set t_ZH=[3m
set t_ZR=[23m
set t_Co=256
set background=dark
"colorscheme material-theme
color dracula

" let g:base16_shell_path=base16-builder/output/shell/

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase smartcase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Use spaces not tabs
filetype plugin indent on
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set showmatch
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set t_ti= t_te=
set lazyredraw
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
set history=10000

" Highlight non-ascii chars and 99th col
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii ctermbg=white ctermfg=black
set colorcolumn=99
"highlight ColorColumn ctermbg=cyan ctermfg=black
highlight Search ctermfg=black ctermbg=yellow
"highlight StatusLine ctermfg=black


" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call StripWhitespace()

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" Clear the search buffer when hitting return¬
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " autocmd FileType python compiler flake8
    " autocmd BufWritePost *.py call Flake8()
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au FileType python setl sw=4 sts=4 ts=4
    au FileType make set noexpandtab shiftwidth=4 softtabstop=0
endif

let python_highlight_all = 1
let python_version_2 = 1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
python << EOF
try:
    from powerline.vim import setup as powerline_setup
    powerline_setup()
    del powerline_setup
except ImportError:
    pass
EOF
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "⚑"
let g:syntastic_style_warning_symbol = "⚑"
let g:syntastic_python_flake8_post_args='--ignore=E501,E121'
" let g:syntastic_python_flake8_post_args='--ignore=E501,E125,E121,E502,E128,E129,E265,E226,E126,E221,E303,302,E271,E261,E127,E131,W291,E231,E262,E202,E302,W293,E203,W391,E116,E301,E201,E251'
" let g:syntastic_python_flake8_post_args='--select=F403,F811,F812,F821,F822,F823,F831,F841,E901,E902'
highlight Comment cterm=italic
