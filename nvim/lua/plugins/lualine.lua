return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
	    local configs = require('lualine').setup({
		    options = { theme = "dracula"  }
	    })
    end
}
