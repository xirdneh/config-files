set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'git://github.com/scrooloose/syntastic.git'
Plugin 'git://github.com/Valloric/YouCompleteMe.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required
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
" Put your non-Plugin stuff after this line

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set hls
set ruler
set laststatus=2
set statusline+=(%n)\ %f\%=\%l,%c:%L\ (%b)\ %h%m%y%r
syntax on
colorscheme distinguished

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = '--load-plugins pylint_django'
let g:syntastic_javascript_checkers = ['jshint']

nnoremap <Space>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <Space>gf :YcmCompleter GoToDefinition<CR>
nnoremap <Space>go :YcmCompleter GoTo<CR>
