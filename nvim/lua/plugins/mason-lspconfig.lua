return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function map_buf(bufnr)
      local function nmap(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      nmap("K", vim.lsp.buf.hover, "Hover Docs")
      nmap("gd", vim.lsp.buf.definition, "Go to Definition")
      nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
      nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
      nmap("gr", vim.lsp.buf.references, "List References")
      nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
      nmap("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format File")
      nmap("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      nmap("]d", vim.diagnostic.goto_next, "Next Diagnostic")
      nmap("<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
    end

    local on_attach = function(_, bufnr)
      map_buf(bufnr)
    end

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd", "jdtls", "lua_ls", "gopls", "pyright",
        "rust_analyzer", "tsserver", "html", "cssls",
      },
      automatic_installation = true,
    })

    local servers = {
      clangd = {},
      jdtls = {},
      lua_ls = {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } }
      },
      gopls = {},
      pyright = {},
      rust_analyzer = {},
      tsserver = {},
      html = {},
      cssls = {},
    }

    for name, config in pairs(servers) do
      config.capabilities = cmp_capabilities
      config.on_attach = on_attach
      vim.lsp.config[name].setup(config)
    end
  end,
}
