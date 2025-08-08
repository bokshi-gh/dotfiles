" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Enable smart auto-indenting when starting a new line
set smartindent

let mapleader = " "

" Open terminal (Vim 8+)
nnoremap <leader>t :terminal<CR>

" Write (save file)
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" Quit without saving
nnoremap <leader>qd :q!<CR>

" Write and quit
nnoremap <leader>wq :wq<CR>
