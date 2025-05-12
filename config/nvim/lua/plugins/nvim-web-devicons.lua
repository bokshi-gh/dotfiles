return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,  -- Loads only when required
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true, -- Enable default icons
      })
    end
  }
}

-- NOTE: You need to setup Nerd Fonts since nvim-web-devicon depends on that

-- Steps to Set Up Nerd Font
-- 1. Download a Nerd Font
-- Choose a font patched with icons from https://www.nerdfonts.com/font-downloads. 
-- Popular choices:
--  JetBrains Mono Nerd Font
--  FiraCode Nerd Font
--  Hack Nerd Font
--  Cascadia Code Nerd Font
--  You can also download from their GitHub releases.

-- 2. Install the Font
-- On Linux: Copy .ttf files to ~/.local/share/fonts/ and run fc-cache -fv
-- On Windows: Right-click the .ttf file and choose Install for all users
-- On macOS: Double-click and install via Font Book

-- 3. Set Terminal to Use the Nerd Font
-- Go to your terminal settings and change the font:

-- Terminal and How to Change Font
-- Alacritty:	Edit ~/.config/alacritty/alacritty.yml → font.family: "JetBrainsMono Nerd Font"
-- Kitty:	    Edit ~/.config/kitty/kitty.conf → font_family JetBrainsMono Nerd Font
-- iTerm2 (macOS): Preferences → Profiles → Text → Font
-- Windows Terminal: Settings → Profile → Appearance → Font face

-- 4. Restart Your Terminal and Neovim
-- Then open Neovim and check if the icons appear correctly in plugins like Neo-tree.

-- Why We Need to Set Up Nerd Font:
-- nvim-web-devicons and various other plugins (like Neo-tree, Lualine, Telescope, etc.)
-- rely on Nerd Fonts to display icons correctly in Neovim. These icons represent file types,
-- folders, and other visual elements within the editor. Without a Nerd Font installed,
-- these icons will not display and will appear as missing or strange characters.
-- Therefore, it's crucial to install and configure a Nerd Font to enable the full icon experience.


