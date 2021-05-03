" I might comment this later

let mapleader = ' '
let maplocalleader = '\'

set number relativenumber

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent smarttab

set ruler

set showtabline=2

set nowrap

set nohlsearch

set signcolumn="yes"

let &colorcolumn="+".join(range(0,254),",+")

nnoremap <C-L> :noh<CR>:mode<CR>
nnoremap <leader>a $i
nnoremap <leader>x $x
inoremap <S-Del> <Nop>
