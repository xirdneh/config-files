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
syntax on
colorscheme distinguished
execute pathogen#infect()
