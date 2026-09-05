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

# Fresh Neovim config
rm -rf \
    "$HOME/.config/nvim" \
    "$HOME/.local/share/nvim" \
    "$HOME/.local/state/nvim" \
    "$HOME/.cache/nvim"

# NvChad
git clone https://github.com/NvChad/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

# Custom configuration
mkdir -p "$HOME/.config/nvim/lua/plugins"

cat > "$HOME/.config/nvim/lua/plugins/custom.lua" <<'EOF'
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
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
      }
    end,
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
}
EOF

# LSP configuration
cat > "$HOME/.config/nvim/lua/configs/lspconfig.lua" <<'EOF'
require("nvchad.configs.lspconfig").defaults()

local servers = {
  "clangd",
  "asm_lsp",
  "rust_analyzer",
  "jdtls",
  "ts_ls",
  "basedpyright",
  "html",
  "cssls",
}

vim.lsp.enable(servers)
EOF

# Mason packages
cat > "$HOME/.config/nvim/lua/chadrc.lua" <<'EOF'
local M = {}

M.base46 = {
  theme = "chadcyan",
}

M.mason = {
  pkgs = {
    -- LSP
    "clangd",
    "asm-lsp",
    "rust-analyzer",
    "jdtls",
    "typescript-language-server",
    "basedpyright",
    "html-lsp",
    "css-lsp",

    -- Formatters
    "clang-format",
    "rustfmt",
    "google-java-format",
    "prettier",
    "black",

    -- Linters
    "clang-tidy",
    "eslint_d",
    "ruff",
    "stylelint",
  },
}

return M
EOF

# Install plugins
echo "==> Syncing plugins..."
nvim --headless -c "Lazy! sync" -c "qa"

# Install Mason packages
echo "==> Installing Mason packages..."
nvim --headless \
    +"lua require('nvchad.mason').install_all()" \
    +"autocmd User MasonUpdateAllComplete qa"

# Install Tree-sitter parsers
echo "==> Installing Tree-sitter parsers..."
nvim --headless -c "TSInstallAll" -c "qa"

echo "==> NvChad setup complete!"

nvim

# After running this setup, check:
# ../docs/nvchad.md
