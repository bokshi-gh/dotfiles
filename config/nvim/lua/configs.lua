vim.g.mapleader = " "

vim.keymap.set('n', '<leader>t', ':terminal<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>qd', ':q!<CR>')
vim.keymap.set('n', '<leader>wq', ':wq<CR>')

vim.keymap.set('n', '<leader>cc', ':!gcc % -o %:r<CR>')
vim.keymap.set('n', '<leader>ccr', ':!gcc % -o %:r && ./%:r<CR>')
vim.keymap.set('n', '<leader>rpy', ':!python3 %<CR>')

-- Toggle absolute line numbers (number)
vim.keymap.set('n', '<leader>tn', function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

-- Toggle relative line numbers (relativenumber)
vim.keymap.set('n', '<leader>trn', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })
