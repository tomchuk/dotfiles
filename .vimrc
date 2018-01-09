" leader
let mapleader = ','

" set undo/backup/swap
silent execute '!mkdir -p ~/.vim/{undo,back,swap}'

" vim-plug: plugin management with lazy loading
" To rebuild `rm -rf ~/.vim/plugged ~/.vim/autoload`
set nocompatible
if ! filereadable($HOME . '/.vim/autoload/plug.vim')
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/plugged')
" Colors/themes
Plug 'KeitaNakamura/neodark.vim'
" Global
Plug 'bogado/file-line'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'gregsexton/MatchTag'
Plug 'majutsushi/tagbar'
Plug 'milkypostman/vim-togglelist'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'dietsche/vim-lastplace'
Plug 'fgsch/vim-varnish'
" Languages

Plug 'vim-scripts/applescript.vim', { 'for': 'applescript' }
Plug 'python-mode/python-mode', { 'for': 'python' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'oscarh/vimerl', { 'for': 'erlang' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'leafo/moonscript-vim', { 'for': 'moon' }
call plug#end()

" interface
colorscheme neodark
highlight Comment cterm=italic
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii ctermbg=white ctermfg=black
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"


" sync default register to clipboard
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" ctrl+p buffer search
nmap  <C-B> :CtrlPBuffer<CR>
if has("unix")
  let g:ctrlp_user_command = "find %s -path '*.git*' -prune -o -type f"
endif

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'monochrome'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  let g:airline_symbols.maxlinenr = ''
endif

" python
autocmd FileType python set ts=4 sw=4 et
let g:pymode = 1
let g:pymode_warnings = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_options_max_line_length = 100
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 0
let g:pymode_breakpoint = 1
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_run = 0
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_python = 'python3'

" Ale
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_column_always = 0
let g:ale_python_flake8_args = '--ignore=E501,E121,E128'
let g:ale_python_mypy_options = '--python-version=3.6 --warn-unused-ignores --warn-unused-configs --follow-imports=silent –-ignore-missing-imports --incremental --disallow-any-explicit --disallow-subclassing-any --warn-return-any --disallow-any-expr'
" let g:ale_python_flake8_args = '--ignore=E501,E125,E121,E502,E128,E129,E265,E226,E126,E221,E303,302,E271,E261,E127,E131,W291,E231,E262,E202,E302,W293,E203,W391,E116,E301,E201,E251'

" tags
nmap <silent> <leader>o :TagbarToggle<CR>

" toggle paste and wrap
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>
nmap <silent> <leader>n :set invnumber<CR>:set number?<CR>
nmap <silent> <leader>r :set invrelativenumber<CR>:set relativenumber?<CR>
nmap <silent> <leader>s :sign unplace *<CR>
nmap <silent> <leader>h :set nonumber<CR>:set norelativenumber<CR>:sign unplace *<CR>

" better home-row movements
" down |  up  | left | right
"  j   |  k   |  l   |  ;
" noremap l h
" noremap ; l
" noremap h ;

" Move half page with Ctrl+J/K
noremap <C-J> <C-D>
noremap <C-K> <C-U>

" strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line('.')
  let c = col('.')
  " do the business:
  %s/\s\+$//e
  " restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" par formatting
if system('par')
  let &formatprg=par\ -w80
endif

" clear hlsearch on enter
nnoremap <CR> :nohlsearch<CR><CR>

" Save as root
nnoremap <leader>W :w !sudo tee % > /dev/null<CR>

" vim settings
set backupdir=~/.vim/back//
set backup
set binary
set colorcolumn=80,100
set cursorline
set completeopt-=preview
set cpoptions=ces$
set directory=~/.vim/swap//
set encoding=utf-8 nobomb
set ffs=unix,dos
set fillchars=vert:·
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set guioptions-=T
set guioptions-=m
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set modeline
set modelines=4
set noerrorbells
set noshowmode
set nostartofline
set swapfile
set number
set relativenumber
set ruler
set scrolloff=3
set shellslash
set shortmess+=atI
set showfulltag
set showmatch
set showmode
set smartcase
set synmaxcol=2048
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
if has('termguicolors')
  set termguicolors
endif
set title
set ts=2 sts=2 sw=2 et ci
set ttyfast
set undodir=~/.vim/undo//
set undofile
set viminfo+=n~/.vim/viminfo
set visualbell
set wildmenu
set wrap
set wrapscan
