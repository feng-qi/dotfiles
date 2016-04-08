"***************** Vundle configure *****************

set nocompatible
filetype off

" install vundle
"	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set Runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" this is the call to begin the Vundle Plugin Opperation
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" git repos:
Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'		" color scheme
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'						" need exuberant-ctags
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'							" color scheme
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'				" statusline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/vim-easy-align'
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'vim-scripts/Conque-Shell'				" shell in vim
"Plugin 'hallison/vim-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'Shougo/vimshell.vim'
"Plugin 'Shougo/vimproc.vim'

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
" highlight CursorLine  term=underline  guibg=#555555  cterm=underline
" set softtabstop=4		" backspace will delete 4 spaces at 1 time

winpos 1133 129			" window position
set lines=54 columns=110	" 25 lines and 80 columnn
set nowrap
set textwidth=0			" don't auto break line

syntax enable			" enable syntax highlight
set shiftwidth=4
set tabstop=4
set number
"set relativenumber		" relative line number
set hlsearch
set autochdir			" change directory automatically
set colorcolumn=80		"set up a ruler at column 80

" set up status bar
set laststatus=2		" always shows status bar
"set statusline=		" clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <M-j> <C-W>w
:nnoremap <M-k> <C-W>p

" YouCompleteMe setting
"set completeopt=longest,menu		" let complete behavior like IDE
"
"let g:ycm_confirm_extra_conf=0		" close load .ycm_extra_conf.py prompt
"let g:ycm_min_num_of_chars_for_completion=2	" complete start from 2nd char
"let g:ycm_seed_identifiers_with_syntax=1	" complete syntactic keyword
"let g:ycm_complete_in_comments=1	" complete in comments
"let g:ycm_complete_in_strings=1		" complete in strings
"let g:ycm_collect_identifiers_from_comments_and_strings=0
"let g:syntastic_always_populate_loc_list = 1
"" let g:ycm_key_list_select_completion = []
"" let g:ycm_key_list_previous_completion = []
"let g:ycm_filetype_blacklist = {
"		\ 'tagbar' : 1,
"		\ 'nerdtree' : 1,
"		\}

" taglist setting
set tags=./tags;/			" find tags file in parent dir recursively
"set taglist window in right, delete the following line if you don't like
let Tlist_Use_Right_Window=1
let Tlist_Auto_Update=1
let Tlist_File_Fold_Auto_Close=1
"auto close Tlist when exiting file.
let Tlist_Exit_OnlyWindow = 1
let g:syntastic_mode_map = {
	\ "mode": "active" }
"	\ "passive_filetypes": ["go"] }

" setup for 'junegunn/vim-easy-align'
nmap gt <Plug>(EasyAlign)
xmap gt <Plug>(EasyAlign)

" setup for Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" setup for plugin 'ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg|so|exe)$',
  \ }

