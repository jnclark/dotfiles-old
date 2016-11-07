execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin indent on

"Color Scheme
syntax enable
set background=dark
colorscheme solarized

"For line numbers, relative to current line
set relativenumber

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

"Enable synctex for pdf viewer
let g:vimtex_latexmk_options='-synctex=1'
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method = 'zathura'

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

"Always have statusline on, even if only one file open
set laststatus=2

"Add in theme for vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_extensions = ['branch','tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message = 'no vc'
let g:airline#extensions#branch#vcs_priority = ["mercurial", "git"]
let g:airline_skip_empty_sections = 1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '^V' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"Enable spellchecking by default, en_us
set spell spelllang=en_us
"spelling suggestions now in popup menu with \s 
nnoremap \s ea<C-X><C-S>
