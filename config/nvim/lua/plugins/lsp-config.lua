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
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- LSP servers for selected languages
          "clangd",          -- C, C++
          "csharp_ls",       -- C#
          "jdtls",           -- Java
          "rust_analyzer",   -- Rust
          "pyright",         -- Python
          "html",            -- HTML
          "cssls",           -- CSS
          "tsserver",        -- JavaScript & TypeScript
          "bashls",          -- Bash
          "lua_ls",          -- Lua
          "gopls",           -- Go
          "asm_lsp",         -- Assembly (if available)
          "sqlls",           -- SQL
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Common LSP keymaps
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
      })
    end,
  },

  -- null-ls for formatters and linters integration
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "williamboman/mason.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatters
          null_ls.builtins.formatting.prettier,       -- JS/TS/HTML/CSS
          null_ls.builtins.formatting.black,          -- Python
          null_ls.builtins.formatting.stylua,         -- Lua
          null_ls.builtins.formatting.gofmt,          -- Go
          null_ls.builtins.formatting.rustfmt,        -- Rust
          null_ls.builtins.formatting.clang_format,   -- C, C++
          null_ls.builtins.formatting.csharpier,      -- C#
          -- No widely used formatter for Java in null-ls, rely on LSP (jdtls)

          -- Linters
          null_ls.builtins.diagnostics.eslint,        -- JS/TS
          null_ls.builtins.diagnostics.flake8,        -- Python
          null_ls.builtins.diagnostics.shellcheck,    -- Bash
          null_ls.builtins.diagnostics.chktex,        -- LaTeX (optional)
          null_ls.builtins.diagnostics.clang_check,   -- C, C++
          -- No widely used linter for C# or Java in null-ls; rely on LSP
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

-- NOTE:

-- 1. External tools to install (Ubuntu/Debian):

-- sudo apt update
-- sudo apt install -y unzip clang-format clang-tools clang clang-tidy nodejs npm python3-pip openjdk-11-jdk

-- Then install language tools:

-- npm install -g eslint prettier csharpier
-- pip3 install black flake8

-- rustup component add rustfmt

-- 2. External tools to install (macOS - using Homebrew):

-- brew install unzip clang-format clang node python openjdk

-- npm install -g eslint prettier csharpier
-- pip3 install black flake8

-- rustup component add rustfmt

-- 3. Java language server (jdtls) requires Java JDK installed (see above).

-- 4. Assembly language support depends on asm_lsp availability in Mason.

-- 5. Make sure the external tools are on your system PATH for Neovim to find them.

-- 6. You can install Mason packages manually with :Mason or automatically via ensure_installed.

