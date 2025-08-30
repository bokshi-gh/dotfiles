return {
  "nvimtools/none-ls.nvim",
  dependencies = { 
    "williamboman/mason.nvim", 
    "jay-babu/mason-null-ls.nvim" 
  },
  config = function()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup({
      ensure_installed = {
        "clang-format",
        "eslint_d",
        "prettier",
        "black",
        "stylua",
        "gofmt",
      },
      automatic_installation = true,
    })

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
      },
    })
  end,
}
