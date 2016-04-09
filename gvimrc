colorscheme solarized

"winpos 1133 129			" window position
set lines=54 columns=100	" 25 lines and 80 columnn

" setup for plugin vim-multiple-cursors
"	- put this *after* colorscheme setup, or it may has no effects
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
"let g:multi_cursor_exit_from_insert_mode = 0

