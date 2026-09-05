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

# JavaScript / TypeScript
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

# LSP config
mkdir -p "$HOME/.config/nvim/lua/plugins"

cat > "$HOME/.config/nvim/lua/plugins/lsp.lua" <<'EOF'
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

    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
}
EOF

nvim

# After running this setup, check:
# ../docs/nvchad.md
