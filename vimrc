execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin indent on

"Color Scheme
syntax enable
set background=dark
colorscheme solarized

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

"For vimtex with neocomplete
let g:tex_flavor='pdflatex'

let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ '\v\\%('
    \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|%(include%(only)?|input)\s*\{[^}]*'
    \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . ')'

"For file searching in vim itself
"Path allows searching recursively in subdirectories
set path+=**
set wildmenu

" Add relative file path to your existing statusline
set statusline+=%F
"Always have statusline on, even if only one file open
set laststatus=2
