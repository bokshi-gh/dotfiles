vim.o.background = "dark"

-- Remove ~ at end of buffer
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE" })

-- Make normal buffer and NeoTree transparent / use terminal background
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
