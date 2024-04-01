set nocompatible
set showmode
set expandtab
set number
set wildmode=longest,list 
syntax on
filetype plugin on

" Installation Pluginmanager
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
 Plug 'ryanoasis/vim-devicons'
 Plug 'preservim/nerdtree'
call plug#end()



