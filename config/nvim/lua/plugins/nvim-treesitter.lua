return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {"asm", "bash", "c", "c_sharp", "cmake", "cpp", "css", "csv", "dockerfile", "gitignore", "go", "html", "java", "javascript", "json", "kotlin", "llvm", "lua", "make", "markdown", "nasm", "nginx", "python", "rust", "tmux", "tsx", "typescript", "vim", "xml"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
}

-- NOTE: You need to install a C compiler (gcc or clang) for Tree-sitter parsers to work.
