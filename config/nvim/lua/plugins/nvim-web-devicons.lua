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

--[[ 
  How to Set Up Nerd Fonts for Neovim on Linux

  Note:
  nvim-web-devicons and many Neovim plugins (Neo-tree, Lualine, Telescope, etc.)
  rely on Nerd Fonts to display icons correctly. Without Nerd Fonts,
  icons will not render and will appear as missing or garbled characters.

  Step 1: Download a Nerd Font
  - Visit https://www.nerdfonts.com/font-downloads
  - Popular fonts:
      * JetBrains Mono Nerd Font
      * FiraCode Nerd Font
      * Hack Nerd Font
      * Cascadia Code Nerd Font
  - Or download from Nerd Fonts GitHub releases:
    https://github.com/ryanoasis/nerd-fonts/releases

  Step 2: Install the Nerd Font on Linux
  - Extract downloaded archive if needed
  - Copy .ttf files to local fonts folder:
      mkdir -p ~/.local/share/fonts
      cp path/to/font-files/*.ttf ~/.local/share/fonts/
  - Update font cache:
      fc-cache -fv

  Step 3: Configure your terminal to use the Nerd Font
  - GNOME Terminal:
      Preferences → Profile → Text → Enable Custom Font → Select your Nerd Font
  - Alacritty:
      Edit ~/.config/alacritty/alacritty.yml
      font:
        family: "FiraCode Nerd Font"
  - Kitty:
      Edit ~/.config/kitty/kitty.conf
      font_family FiraCode Nerd Font
  - Restart terminal after changing font

  Step 4: Restart Terminal and Neovim
  - After restarting, open Neovim
  - Icons in plugins like nvim-web-devicons, neo-tree, lualine, telescope should display correctly

  Why this matters:
  - Nerd Fonts patch fonts with icon glyphs for files, folders, UI, etc.
  - Without Nerd Fonts, icons will be missing or corrupted
  - Proper font setup enables rich, clear Neovim UI with icons
]]


