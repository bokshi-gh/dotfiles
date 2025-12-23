vim.g.mapleader = " "

vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = "Open terminal" })

vim.keymap.set('n', '<leader>rc', ':!gcc % -o %:r && ./%:r<CR>', { desc = "Compile & run C file" })
vim.keymap.set('n', '<leader>rcpp', ':!g++ % -o %:r && ./%:r<CR>', { desc = "Compile & run C++ file" })
vim.keymap.set('n', '<leader>rrs', ':!cargo run<CR>', { desc = "Run Rust project with Cargo" })
vim.keymap.set('n', '<leader>rgo', ':!go run %<CR>', { desc = "Run Go file" })
vim.keymap.set('n', '<leader>rjv', ':!javac % && java %:r<CR>', { desc = "Compile & run Java file" })
vim.keymap.set('n', '<leader>rpy', ':!python %<CR>', { desc = "Run Python file" })
vim.keymap.set('n', '<leader>rjs', ':!node %<CR>', { desc = "Run Node.js file" })

vim.keymap.set('n', '<leader>n', function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

vim.keymap.set('n', '<leader>r', function()
  vim.wo.number = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })
