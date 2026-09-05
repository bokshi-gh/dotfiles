#!/bin/bash

sudo pacman -Syu --noconfirm

# Basic tools
sudo pacman -S --needed --noconfirm \
    git \
    neovim \
    tree-sitter-cli \
    ripgrep \
    base-devel \
    unzip

# C/C++
sudo pacman -S --needed --noconfirm \
    gcc \
    gdb \
    clang \
    cmake

# Assembly
sudo pacman -S --needed --noconfirm \
    nasm

# Rust
sudo pacman -S --needed --noconfirm \
    rustup

rustup default stable

# Java
sudo pacman -S --needed --noconfirm \
    jdk-openjdk

# JavaScript / TypeScript / React
sudo pacman -S --needed --noconfirm \
    nodejs \
    npm

# Python
sudo pacman -S --needed --noconfirm \
    python \
    python-pip

# NvChad
git clone https://github.com/NvChad/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

# Custom plugins
mkdir -p "$HOME/.config/nvim/lua/plugins"

cat > "$HOME/.config/nvim/lua/plugins/custom.lua" <<'EOF'
return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "asm_lsp",
        "rust_analyzer",
        "jdtls",
        "ts_ls",
        "basedpyright",
        "html",
        "cssls",
      },
      automatic_enable = true,
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        java = { "google-java-format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        python = { "black" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        c = { "clangtidy" },
        cpp = { "clangtidy" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "ruff" },
        css = { "stylelint" },
      }

      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "asm",
        "rust",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "html",
        "css",
      },
    },
  },
}
EOF

# Install plugins
nvim --headless "+Lazy! sync" +qa

# Install LSPs, formatters, linters and parsers
nvim --headless "+MasonInstallAll" "+TSInstallAll" +qa

nvim

# After running this setup, check:
# ../docs/nvchad.md
