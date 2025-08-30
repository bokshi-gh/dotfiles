return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", 
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set('n', '<leader>ntl', ':Neotree filesystem reveal left<CR>')
		vim.keymap.set('n', '<leader>ntr', ':Neotree filesystem reveal right<CR>')
		vim.keymap.set('n', '<leader>ntt', ':Neotree filesystem reveal top<CR>')
		vim.keymap.set('n', '<leader>ntb', ':Neotree filesystem reveal bottom<CR>')
		vim.keymap.set('n', '<leader>ntc', ':Neotree close<CR>')
	end
}
