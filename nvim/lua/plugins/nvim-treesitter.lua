return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {"asm", "bash", "c", "c_sharp", "cmake", "cpp", "css", "csv", "dockerfile", "gitignore", "go", "git_config", "html", "java", "javascript", "json", "kotlin", "llvm", "lua", "make", "markdown", "nasm", "nginx", "python", "php", "proto", "rust", "sql", "ssh_config", "tmux", "toml", "tsx", "typescript", "vim", "xml", "yaml"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = false },  
        })
    end
}

-- NOTE: You need to install a C compiler (gcc or clang) for Tree-sitter parsers to work.
