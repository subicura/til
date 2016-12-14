# vimrc sample

```
" General
set nocompatible          " 오리지널 vi 호환성 없음 
syntax enable             " syntax highlighting
colorscheme spacegray     " color theme
set term=screen-256color  " use 256color
set nobackup              " backup file 생성안함
set history=1000          " set history 1,000
filetype on
filetype plugin on
filetype plugin indent on

" UI
set number                " 줄번호
set visualbell            " use flash instead of beep
set hlsearch              " 검색어 강조
set showmatch             " show {}() match

" Formatting
set expandtab             " use space instead of tab
set cindent               " c스타일 들여쓰기
set autoindent            " 자동들여쓰기
set smartindent           " 지능적인 들여쓰기
set shiftwidth=2          " 들여쓰기
set ignorecase            " 검색시 대소문자 구분 안함
set paste                 " 그대로 붙여넣기

" Keymap
nmap <F7> :NERDTreeToggle<CR>

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'The-NERD-Tree'
Bundle 'https://github.com/Lokaltog/vim-powerline.git' 

call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" for NERDTree
let NERDTreeWinPos = "right"
autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif
autocmd VimEnter * if &filetype !=# 'gitcommit' | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
```

