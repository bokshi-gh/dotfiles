return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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
        "rust_analyzer", "tsserver", "html", "cssls",
      },
      automatic_installation = true,
    })

    require("mason-lspconfig").setup_handlers({
      -- default setup for all servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = cmp_capabilities,
          on_attach = on_attach,
        })
      end,
      -- overrides
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = cmp_capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    })
  end,
}
