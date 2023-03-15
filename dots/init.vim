set number
set tabstop=4
set shiftwidth=4
set wildmenu
set cursorline
hi CursorLine ctermbg=232 term=None cterm=None
hi Search ctermbg=green
set conceallevel=1
colorscheme slate
syntax on
hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=9 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC ctermfg=15 guifg=#b2b2b2 ctermbg=172 guibg=#3a3a3a cterm=bold gui=bold


call plug#begin()

Plug 'eandrju/cellular-automaton.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()


lua << CODE
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
CODE



