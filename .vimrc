filetype on
filetype plugin on
filetype indent on 
syntax on

call plug#begin()
Plug 'catppuccin/vim', {'as':'catppuccin'}
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
call plug#end()
if has ("termguicolors")
	set termguicolors
endif
colorscheme catppuccin_latte

set cursorline
set wildmenu
set number
set relativenumber
set colorcolumn=100
set signcolumn=yes
set cmdheight=1
set scrolloff=15

set tabstop=2
set shiftwidth=2
set softtabstop=2

let mapleader = " "
nnoremap <Leader>t :NERDTreeToggle<CR>
