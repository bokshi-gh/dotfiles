return {
  -- Mason: Installer for LSP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason-lspconfig bridge & LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local servers = mason_lspconfig.get_available_servers()

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs", buffer = bufnr })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration", buffer = bufnr })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", buffer = bufnr })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List References", buffer = bufnr })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format File", buffer = bufnr })

                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", buffer = bufnr })
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic", buffer = bufnr })
              end,
            })
          end,
        },
      })
    end,
  },

  -- null-ls for formatters and linters integration
  {
    "nvimtools/none-ls.nvim",
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
          null_ls.builtins.formatting.csharpier,

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

  -- Autocomplete engine and snippet support
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

-- SYSTEM DEPENDENCY NOTE:

-- External runtimes required (Mason cannot install these):
--
-- Install system dependencies (Ubuntu/Debian):
--   sudo apt update
--   sudo apt install -y unzip clang-format clang-tools clang clang-tidy nodejs npm openjdk-11-jdk dotnet-sdk-6.0 shellcheck chktex python3 flake8
--
-- C# formatter (csharpier) — install via .NET SDK:
--   dotnet tool install -g csharpier
--   # Make sure ~/.dotnet/tools is in your PATH
--
-- JS/TS formatters and linters:
--   npm install -g eslint prettier
--
-- Rust toolchain:
--   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
--   export PATH="$HOME/.cargo/bin:$PATH"
--   rustup component add rustfmt
