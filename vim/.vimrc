" Enable line numbers
set number

" Enable syntax highlighting
syntax on

let mapleader = " "

set timeout          " enable timeout for mapped sequences
set timeoutlen=1000  " wait 2000 ms (2 second)

" Open terminal (Vim 8+)
nnoremap <leader>t :terminal<CR>

" Write (save file)
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" Quit without saving
nnoremap <leader>Q :q!<CR>

" Write and quit
nnoremap <leader>wq :wq<CR>
