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
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'ajh17/Spacegray.vim'
Plug 'morhetz/gruvbox'
" Global
Plug 'zxqfl/tabnine-vim'
Plug 'bogado/file-line'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gregsexton/MatchTag'
Plug 'majutsushi/tagbar'
Plug 'milkypostman/vim-togglelist'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/a.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'dietsche/vim-lastplace'
Plug 'fgsch/vim-varnish'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'jaxbot/semantic-highlight.vim'
" Languages

Plug 'sheerun/vim-polyglot'
Plug 'leafo/moonscript-vim', { 'for': 'moon' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
call plug#end()

" interface
set background=dark
let g:gruvbox_italic = 1
colorscheme gruvbox
let g:solarized_termcolors = 256
let g:solarized_termtrans = 0
let g:solarized_degrade = 0
let g:solarized_bold = 1
let g:solarized_italic = 1
let g:solarized_contrast = "normal"
let g:solarized_visibility = "normal"
let g:spacegray_underline_search = 0
let g:spacegray_use_italics = 1
let g:spacegray_low_contrast = 1
" let g:semanticGUIColors = ['#b58900', '#cb4b16', '#dc322f', '#d33682', '#6c71c4', '#268bd2', '#2aa198', '#859900']
let g:semanticGUIColors = ['#928374', '#9d0006', '#79740e', '#b57614', '#076678', '#8f3f71', '#427b58', '#af3a03']
highlight Normal ctermbg=none
highlight Visual ctermbg=black
highlight Comment cterm=italic
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii ctermbg=white ctermfg=black
" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"


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


" python
autocmd FileType python set ts=4 sw=4 et
let g:python_highlight_class_vars = 1
let g:python_highlight_all = 1
let g:python_pep8_indent_multiline_string = -2

" Ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 500
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_column_always = 0
let g:ale_python_flake8_options = '--ignore=E501,W504,W503 --exclude=""'
let g:ale_python_mypy_options = '--python-version=3.7 --ignore-missing-imports --follow-imports silent --disallow-untyped-calls --disallow-untyped-defs --disallow-incomplete-defs --check-untyped-defs --incremental'
" let g:ale_python_mypy_options = '--python-version=3.7 --warn-unused-ignores --warn-unused-configs --follow-imports=silent –-ignore-missing-imports --incremental --disallow-any-explicit --disallow-subclassing-any --warn-return-any --disallow-any-expr'
" let g:ale_python_flake8_options = '--ignore=E501,E125,E121,E502,E128,E129,E265,E226,E126,E221,E303,302,E271,E261,E127,E131,W291,E231,E262,E202,E302,W293,E203,W391,E116,E301,E201,E251'

" tags
nmap <silent> <leader>o :TagbarToggle<CR>

" toggle paste and wrap
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>
nmap <silent> <leader>n :set invnumber<CR>:set number?<CR>:set invrelativenumber<CR>:set relativenumber?<CR>
nmap <silent> <leader>r :set invrelativenumber<CR>:set relativenumber?<CR>
nmap <silent> <leader>s :SemanticHighlightToggle<CR>
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
noremap <C-H> g<Home>
noremap <C-L> g<End>
" Map F1 to Esc - stupid touchbar
map <F1> <Esc>
imap <F1> <Esc>

" Move through wrapped lines naturally
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> ^ g^
noremap <buffer> <silent> $ g$
noremap <buffer> <silent> <Up> gk
noremap <buffer> <silent> <Down> gj
noremap <buffer> <silent> <Home> g<Home>
noremap <buffer> <silent> <End> g<End>
inoremap <buffer> <silent> <Up> <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End> <C-o>g<End>

nmap <silent> <C-n> <Plug>(ale_previous_wrap)
nmap <silent> <C-p> <Plug>(ale_next_wrap)

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
set guicursor=
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
set regexpengine=1
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
"if has('termguicolors')
"  set termguicolors
"endif
set title
set ts=2 sts=2 sw=2 et ci
set ttyfast
set undodir=~/.vim/undo//
set undofile
set visualbell
set wildmenu
set wrap
set wrapscan
if !has('nvim')
  set viminfo+=n~/.vim/viminfo
endif
