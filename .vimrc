"***************** Vundle configure *****************

set nocompatible
filetype off

" set Runtime path to include Vundle and initialize
set rtp+=E:\Vim/vimfiles/bundle/Vundle.vim

" this is the call to begin the Vundle Plugin Opperation
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" git repos:
Plugin 'tomasr/molokai'		" color scheme
Plugin 'altercation/vim-colors-solarized'		" color scheme
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'

" Plugin 'Shougo/vimshell.vim'
"Plugin 'Valloric/YouCompleteMe'

" All of you Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"***************** End configure *****************

" Put your non-Plugin stuff after this line


colorscheme solarized
set background=dark
set guicursor=a:blinkon0
set guioptions-=m		" hide menu bar
set guioptions-=T		" hide tool bar
set guioptions-=L
set guioptions-=r
set visualbell
set cursorline
" set softtabstop=4		" backspace will delete 4 spaces at 1 time

winpos 1068 119			" window position
set lines=54 columns=104	" 25 lines and 80 columnn

syntax enable			" enable syntax highlight
set shiftwidth=4
set tabstop=4
set number
set hlsearch

set autochdir			" change directory automatically
" set encoding=utf-8

