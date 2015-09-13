set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set hls
set ruler
set statusline+=(%n)\ %f\%=\%l,%c:%L\ (%b)\ %h%m%y%r

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

syntax on
colorscheme distinguished
execute pathogen#infect()
