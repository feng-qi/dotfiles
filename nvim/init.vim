tnoremap <Esc> <C-\><C-n>
set inccommand=split
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
