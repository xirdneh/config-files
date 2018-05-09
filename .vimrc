set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'git://github.com/scrooloose/syntastic.git'
Plugin 'git://github.com/Valloric/YouCompleteMe.git'
Bundle 'Rykka/riv.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

set tabstop=4            " Tab is 4 spaces
set shiftwidth=4         " Same as tabstop
set autoindent           " Match previous line indent
set expandtab            " Tabs are spaces
set smarttab 
set incsearch            " Highlight commands
set wildmenu             " Enhanced command line
set scrolloff=5          " Always show 5 lines before and after cursor
set display+=lastline    " Show long lines as much as possible
set spell spelllang=en_us " Set spellcheck
set encoding=utf-8
"set mouse=n
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set hls
set ruler
set laststatus=2
set statusline+=(%n)\ %f\%=\%l,%c:%L\ (%b)\ %h%m%y%r
syntax on
colorscheme distinguished

let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_pylint_args = '--load-plugins pylint_django'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_aggregate_errors = 1

let g:riv_python_rst_hl = 1

nnoremap <Space>ch :noh<CR>
nnoremap <Space>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <Space>gf :YcmCompleter GoToDefinition<CR>
nnoremap <Space>gr :YcmCompleter GoToReferences<CR>
nnoremap <Space>go :YcmCompleter GoTo<CR>
nnoremap <Space>sr :SyntasticReset<CR>

hi clear SpellBad
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare
hi SpellBad    cterm=underline  ctermfg=LightRed
hi SpellCap    cterm=italic     ctermfg=LightYellow
hi SpellLocal  cterm=underline  ctermfg=LightBlue
hi SpellRare   cterm=underline  ctermfg=LightGray
