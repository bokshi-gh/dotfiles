return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
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
          "rust_analyzer", "ts_ls", "html", "cssls"
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
        tsserver = {},
        html = {},
        cssls = {},
      }

      for name, config in pairs(servers) do
        config.capabilities = cmp_capabilities
        config.on_attach = on_attach
        lspconfig[name].setup(config)
      end
    end,
  },

  -- nvim-cmp setup (completion)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- null-ls (formatting & linting)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "jay-babu/mason-null-ls.nvim" },
    config = function()
      local null_ls = require("null-ls")

      require("mason-null-ls").setup({
        ensure_installed = {
          "clang-format", "eslint_d", "prettier",
          "black", "stylua", "gofmt", "rustfmt",
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
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.diagnostics.eslint_d,
        },
      })
    end,
  },
}
