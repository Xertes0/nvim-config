syntax on

nnoremap <SPACE> <Nop>
let mapleader=" "

"let g:nord_contrast = v:true
lua require('plugins')
lua require('configs').config()

nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>s :SymbolsOutline<CR>

"set spell
set signcolumn=yes

set number
set hidden
set scrolloff=2
set hlsearch
set incsearch
set mouse=a

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"colorscheme gruvbox-baby
"colorscheme nord
colorscheme nordfox

set smarttab
" on tab spaces
"set expandtab
" show tab as
set tabstop=2
set softtabstop=2
" indenting with >
set shiftwidth=2

set autoindent
set smartindent

" only on master branch
set cmdheight=0
