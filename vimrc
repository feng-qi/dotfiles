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
Plugin 'altercation/vim-colors-solarized'		" color scheme
Plugin 'majutsushi/tagbar'						" need exuberant-ctags
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'							" color scheme
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'vim-airline/vim-airline'				" statusline
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/vim-easy-align'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mileszs/ack.vim'						" need ack-grep
Plugin 'tommcdo/vim-exchange'					" swap two regions of text
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'jiangmiao/auto-pairs'
Plugin 'plasticboy/vim-markdown'				" need 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'scrooloose/syntastic'
" Plugin 'othree/xml.vim'
" Plugin 'mattn/emmet-vim'
" Plugin 'godlygeek/tabular'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'ARM9/arm-syntax-vim'

" All of you Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

"***************** End configure *****************

set encoding=utf-8
"set langmenu=zh_CN.UTF-8
"language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

if has('gui_running')
	colorscheme solarized
	set lines=53 columns=100	" 25 lines and 80 columnn

	" setup for plugin vim-multiple-cursors
	"	- put this *after* colorscheme setup, or it may has no effects
	highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
	highlight link multiple_cursors_visual Visual
	"let g:multi_cursor_exit_from_insert_mode = 0

	set guicursor=a:blinkon0
	" set guioptions=aegit	" default
	set guioptions=
	"set guioptions-=m		" hide menu bar
	"set guioptions-=T		" hide tool bar
	"set guioptions-=L
	"set guioptions-=r
else
	"colorscheme molokai
endif

if has('win32')
	set guifont=Source_Code_Pro:h10:cANSI:qDRAFT
elseif has('unix')
	set guifont=Source\ Code\ Pro\ 11
endif

set clipboard=unnamed
set winaltkeys=no			" Alt key will not pop out menu bar menus
set background=dark
set visualbell
set showcmd
set hidden
set ignorecase
set incsearch			" become useless while plugin easymotion presents
set infercase

set nowrap
set textwidth=0			" don't auto break line

syntax enable			" enable syntax highlight
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4		" backspace will delete 4 spaces at 1 time
set number
set history=200
"set relativenumber		" relative line number
set hlsearch
"set autochdir			" change directory automatically
set cursorline
"highlight CursorLine  term=underline  guibg=#555555  cterm=underline
set colorcolumn=80		"set up a ruler at column 80
"highlight ColorColumn ctermbg=0 guibg=lightgrey
"set foldmethod=indent	" fold according to indentation

" Use the same symbols as TextMate for tabstops and EOLs
" set listchars=tab:▸\ ,eol:¬,trail:·		" space:·
set listchars=tab:»-,eol:¶,trail:·
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" setup for word complete, Ctrl-x_Ctrl-k
set dictionary+=/usr/share/dict/words

" enable omni completion
"set omnifunc=syntaxcomplete#Complete

" set up status bar
set laststatus=2		" always shows status bar

let mapleader=" "
" expand '%%' to current file folder, %:h : % get full path to file, :h remove filename
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <C-n>  <Down>
cnoremap <C-p>  <Up>
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <C-f>  <Right>
cnoremap <C-n>  <Down>
cnoremap <C-p>  <Up>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>

inoremap <C-u>      <esc>gUiwea
inoremap <C-e>      <esc>A

nnoremap <F12>      :source ~/vimsession<cr>
nnoremap <F10>      :mksession! ~/vimsession<cr>
nnoremap <c-tab>    :tabnext<cr>
nnoremap <c-s-tab>  :tabprevious<cr>
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Be like spacemacs
nnoremap <leader><tab> <C-^>
nnoremap <leader>fs :w<cr>
nnoremap <leader>fS :wa<cr>
nnoremap <leader>fr :browse oldfiles<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :windo diffthis<cr>
nnoremap <leader>gD :windo diffoff<cr>
nnoremap <leader>qq :qa<cr>
nnoremap <leader>sc :nohlsearch<cr>
nnoremap <leader>wd :q<cr>
nnoremap <leader>wD :q!<cr>
nnoremap <leader>w- :sp<cr>
nnoremap <leader>w/ :vsp<cr>
nnoremap <leader>1  1<C-w>w
nnoremap <leader>2  2<C-w>w
nnoremap <leader>3  3<C-w>w
nnoremap <leader>4  4<C-w>w
nnoremap <leader>5  5<C-w>w
nnoremap <leader>6  6<C-w>w
nnoremap <leader>7  7<C-w>w
nnoremap t F
nnoremap ' `

" setup for 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" YouCompleteMe setting
"set completeopt=longest,menu		" let complete behavior like IDE
"let g:ycm_confirm_extra_conf=0		" close load .ycm_extra_conf.py prompt
"let g:ycm_min_num_of_chars_for_completion=2	" complete start from 2nd char
"let g:ycm_seed_identifiers_with_syntax=1	" complete syntactic keyword
"let g:ycm_complete_in_comments=1	" complete in comments
"let g:ycm_complete_in_strings=1		" complete in strings
"let g:ycm_collect_identifiers_from_comments_and_strings=0
"let g:ycm_key_list_select_completion = []
"let g:ycm_key_list_previous_completion = []
"let g:ycm_filetype_blacklist = {
"		\ 'tagbar' : 1,
"		\ 'nerdtree' : 1,
"		\}

" setup for plugin syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

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

" setup for Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" setup for plugin 'ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*~,tags     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git)$',
			\ 'file': '\v\.(log|jpg|png|jpeg|so|o|a|exe|out)$',
			\ }
if (executable('ag'))
	let g:ctrlp_user_command = 'ag %s -p ~/.agignore -t --nocolor -g ""'
	let g:ackprg = 'ag --nogroup --nocolor --column'	" change ack program to ag
endif
let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 40
let g:ctrlp_max_height = 10			" set result window height
let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_working_path_mode = '0'

" setup for plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" setup for plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enable = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" setup for plugin 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
"nmap F <Plug>(easymotion-bd-f)
"nmap F <Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-bd-f2)
"nmap / <Plug>(easymotion-sn)
"nmap n <Plug>(easymotion-next)
"nmap N <Plug>(easymotion-prev)

" setup for fortran
"let fortran_free_source = 1
"let fortran_have_tabs = 1
"let fortran_more_precise = 1
"let fortran_do_enddo = 1

" Shortcuts
"	dictionary completion : <C-x><C-k>
"	insert/delete indent  : <C-t>/<C-d>
"	correct spelling error:
"		[s: previous error
"		]s: next error
"		z=: correction list
"		<C-x>s : correction in insert mode
"	zj/zk: jump between folds
"	:windo diffthis/diffoff
"		[c, ]c, diffget, diffput
"	q: "open command history
"	:retab

