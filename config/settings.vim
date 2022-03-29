" set conceallevel=1
set laststatus=0
set nocompatible               " disable compatibility to old-time vi
set hidden
set showmatch                  " show matching
set ignorecase                 " case insensitive
set tabstop=4                  " number of columns occupied by a tab
set softtabstop=4              " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                  " converts tabs to white space
set shiftwidth=4               " width for autoindents
set relativenumber             " enable hybrid line numbers
set number                     " show line numbers
set autoindent                 " indent a new line the same amount as the line just typed
set splitbelow
set splitright
set wildmode=longest,list      " get bash-like tab completions
set encoding=UTF-8             " set encoding to utf-8
set clipboard=unnamedplus      " using system clipboard
set mouse=a
set cursorline                 " highlight current cursorline
set ttyfast                    " speed up scrolling in Vim
set termguicolors              " enable true colors support
set updatetime=300
set shortmess+=c
set nowrap
set title
set titlestring=%t%m
set diffopt+=iwhiteall,algorithm:patience
set wildmenu
set wildignore+=*/.git/*,*/node_modules/*,*/.sass-cache/*,*/vendor/*
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
