vim.g.mapleader = " "

vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = "Open terminal" })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit file" })
vim.keymap.set('n', '<leader>qd', ':q!<CR>', { desc = "Force quit without saving" })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = "Save and quit" })

vim.keymap.set('n', '<leader>rc', ':!gcc % -o %:r && ./%:r<CR>', { desc = "Compile & run C file" })
vim.keymap.set('n', '<leader>rcpp', ':!g++ % -o %:r && ./%:r<CR>', { desc = "Compile & run C++ file" })
vim.keymap.set('n', '<leader>rrs', ':!cargo run<CR>', { desc = "Run Rust project with Cargo" })
vim.keymap.set('n', '<leader>rgo', ':!go run %<CR>', { desc = "Run Go file" })
vim.keymap.set('n', '<leader>rjv', ':!javac % && java %:r<CR>', { desc = "Compile & run Java file" })
vim.keymap.set('n', '<leader>rpy', ':!python %<CR>', { desc = "Run Python file" })
vim.keymap.set('n', '<leader>rjs', ':!node %<CR>', { desc = "Run Node.js file" })

vim.keymap.set('n', '<leader>tn', function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

vim.keymap.set('n', '<leader>trn', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })
