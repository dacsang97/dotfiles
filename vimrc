" Load vim-plug
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Leader
let mapleader = " "

" Encoding UTF8
set encoding=utf8

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Color Scheme
set background=dark
set termguicolors
let g:nord_bold=0
let g:nord_italic=1
let g:nord_italic_comments=1
let g:nord_uniform_diff_background=1
colorscheme nord

" Exit
inoremap jk <Esc>
inoremap <Esc> <Nop>

set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite

set autoindent
set smartindent

set autoread
set autowrite

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Open new split panes to right and bottom
set splitbelow
set splitright

" Display kiu message :3
echo ">^.^<"

" Numbers
set number
set relativenumber
set numberwidth=5

" Copy to clipboard
set clipboard=unnamed

" Use tab with text block
vmap <Tab> >gv
vmap <S-Tab> <gv

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <Leader>\ :vsplit<CR>
nnoremap <Leader>/ :split<CR>

nnoremap <Leader>w :w<CR>

" Remove highlight
map <C-h> :nohl<CR>

" Nerd Tree Map
nnoremap <silent> <Leader>e <Esc>:NERDTreeToggle<CR>
nnoremap <silent> <Leader>f <Esc>:NERDTreeFind<CR>
let NERDTreeMapOpenSplit = 'x'
let NERDTreeMapOpenVSplit = 'v'

" FZF Vim Settings
nnoremap <C-p> :Files<CR>

" Comment
map mm <Plug>NERDCommenterToggle

" Lightline
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'component_function': {
  \   'fileicon': 'MyFiletype',
  \   'fileformat': 'MyFileformat',
  \   'cocstatus': 'coc#status',
  \   'filename': 'LightLineFilename',
  \   'nearmethod': 'NearestMethodOrFunction',
  \   'icongitbranch': 'DrawGitBranchInfo'
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'active': {
  \   'left': [ ['icongitbranch'], ['filename', 'nearmethod'], ['cocstatus'] ],
  \   'right': [ ['fileicon', 'percent', 'lineinfo'] ]
  \ },
  \ 'separator': { 'left': "\ue0c0", 'right': "\ue0b2" },
	\ 'subseparator': { 'left': "\ue0c1", 'right': "\ue0b3" }
  \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightLineFilename()
  let name = ""
  let subs = split(expand('%'), "/")
  let i = 1
  for s in subs
    let parent = name
    if  i == len(subs)
      let name = len(parent) > 0 ? parent . '/' . s : s
    elseif i == 1
      let name = s
    else
      let part = strpart(s, 0, 10)
      let name = len(parent) > 0 ? parent . '/' . part : part
    endif
    let i += 1
  endfor
  return name
endfunction

function! NearestMethodOrFunction() abort
  let fname = get(b:, 'vista_nearest_method_or_function', '')
  return len(fname) > 0 ? "\u0192 " . fname : ""
endfunction

function! DrawGitBranchInfo()
  let branch = fugitive#head()
  return len(branch) > 0 ? " " . branch : ""
endfunction

" Vim Close Tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

iabbrev @@ dacsang97@gmail.com

