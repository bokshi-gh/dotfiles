vim.g.mapleader = " "

vim.keymap.set('n', '<leader>sn', ':set number')
vim.keymap.set('n', '<leader>un', ':set nonumber')

vim.keymap.set('n', '<leader>t', ':terminal<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>qd', ':q!<CR>')
vim.keymap.set('n', '<leader>wq', ':wq<CR>')

vim.keymap.set('n', '<leader>cc', ':!gcc % -o %:r<CR>')
vim.keymap.set('n', '<leader>ccr', ':!gcc % -o %:r && ./%:r<CR>')
vim.keymap.set('n', '<leader>rpy', ':!python3 %<CR>')



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
