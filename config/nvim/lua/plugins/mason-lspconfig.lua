return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Helper function for keymaps
    local function map(mode, lhs, rhs, desc, bufnr)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    local on_attach = function(_, bufnr)
      map("n", "K", vim.lsp.buf.hover, "Hover Docs", bufnr)
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition", bufnr)
      map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration", bufnr)
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation", bufnr)
      map("n", "gr", vim.lsp.buf.references, "List References", bufnr)
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol", bufnr)
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action", bufnr)
      map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, "Format File", bufnr)
      map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic", bufnr)
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic", bufnr)
      map("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic", bufnr)
    end

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "jdtls", "lua_ls", "gopls", "pyright",
        "rust_analyzer", "ts_ls", "html", "cssls",
      },
      automatic_installation = true,
    })

    local servers = {
      clangd = {},
      jdtls = {},
      lua_ls = {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      },
      gopls = {},
      pyright = {},
      rust_analyzer = {},
      ts_ls = {},
      html = {},
      cssls = {},
    }

    for name, config in pairs(servers) do
      config.capabilities = cmp_capabilities
      config.on_attach = on_attach
      lspconfig[name].setup(config)
    end
  end,
}
