""" 
""" neovim configuration
"""


""" PLUGINS
call plug#begin()

" Theming
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


""" THEMING

colorscheme catppuccin

" Line numbers
set number

" Airline config
let g:airline_theme = 'catppuccin'
let g:airline#extensions#whitespace#enabled = 0

""" EDITOR

" Tab width
set tabstop=4
set shiftwidth=4
