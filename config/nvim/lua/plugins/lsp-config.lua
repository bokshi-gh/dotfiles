return {
  -- mason: Installer for LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- mason-lspconfig: bridge between mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.3.0",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Automatically install specified servers
      mason_lspconfig.setup({
        ensure_installed = { "bashls", "clangd", "lua_ls", "pyright", "rust_analyzer", "tsserver" },
        automatic_installation = true,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = function(_, bufnr)
              local map = function(mode, key, fn, desc)
                vim.keymap.set(mode, key, fn, { buffer = bufnr, desc = desc })
              end
              map("n", "K", vim.lsp.buf.hover, "Hover Docs")
              map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
              map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
              map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
              map("n", "gr", vim.lsp.buf.references, "List References")
              map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
              map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
              map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format File")
              map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
              map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
              map("n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic")
            end,
          })
        end,
      })
    end,
  },

  -- null-ls: for formatters and linters integration
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "williamboman/mason.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatters
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.clang_format,

          -- Linters
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.chktex,
          null_ls.builtins.diagnostics.clang_check,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<leader>F", function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end, { buffer = bufnr, desc = "Format buffer with null-ls" })
          end
        end,
      })
    end,
  },

  -- nvim-cmp: Autocomplete engine and snippet support
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}

