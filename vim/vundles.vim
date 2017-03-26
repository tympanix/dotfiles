" ========================================
" Vim plugin configuration
" ========================================

" Filetype off is required by vundle
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins for vim
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
" Plugin 'mhartington/oceanic-next'
Plugin 'edkolev/tmuxline.vim'

" All of your Plugins must be added before the following line
call vundle#end()

" Load local bundles
if filereadable(expand("~/.vim/vundles.local"))
	source ~/.vim/vundles.local
endif

"Filetype plugin indent on is required by vundle
filetype plugin indent on
