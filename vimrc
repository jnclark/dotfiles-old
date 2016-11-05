execute pathogen#infect()

syntax on
filetype plugin indent on

"For line numbers
set number

"Wrap lines
set wrap
set linebreak

"Tabs are 4 spaces, and autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

"For LaTeXsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='pdflatex'
