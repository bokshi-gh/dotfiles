return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,  -- Loads only when required
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true, -- Enable default icons
      })
    end
  }
}

