set expandtab
set tabstop=2
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and  '>'

filetype plugin on
"filetype plugin indent on
"set omnifunc=syntaxcomplete#Complete

set hidden
syntax on
set incsearch
set hlsearch
set autowrite

"search ignore case
set ignorecase

set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set nowrap        " don't wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
"set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000
set undolevels=1000

set title

"Jumping between buffers
nnoremap gb :ls<CR>:b<Space>

"a better color scheme for vimdiff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
