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

-- ---------------------------------------------------------------
-- Nerd Fonts Setup for Linux (Arch / Pacman)
--
-- Many Neovim plugins (nvim-web-devicons, Neo-tree, Lualine, Telescope)
-- require Nerd Fonts to display icons correctly.
--
-- Step 1: Install an AUR helper if you don't have one:
--   sudo pacman -S --needed git base-devel
--   git clone https://aur.archlinux.org/yay.git
--   cd yay
--   makepkg -si
--
-- Step 2: Install JetBrains Mono Nerd Font via AUR:
--   yay -S ttf-jetbrains-mono-nerd
--
-- Alternative fonts:
--   yay -S nerd-fonts-fira-code
--   yay -S nerd-fonts-hack
--   yay -S nerd-fonts-cascadia-code
--
-- Step 3: Verify font installation:
--   fc-list | grep "JetBrains"
--
-- Step 4: Configure your terminal to use the Nerd Font:
--   - GNOME Terminal: Preferences → Profile → Text → Enable Custom Font → Select Nerd Font
--   - Alacritty: ~/.config/alacritty/alacritty.yml → font: family: "JetBrainsMono Nerd Font"
--
-- Step 5: Restart terminal and Neovim
--   - Plugins like nvim-web-devicons, Neo-tree, Lualine, Telescope
--     should now display icons correctly.
-- ---------------------------------------------------------------

