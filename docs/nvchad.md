# NvChad

## References

- [**Docs**](https://nvchad.com/docs/quickstart/install)
- [**Tutorial**](https://youtu.be/Mtgo-nP_r8Y?si=zVTb6dbvyACUSGIl)

## Post [setup-nvchad.sh](../scripts/setup-nvchad.sh)

- Run `:MasonInstallAll` and `:TSInstallAll` after `lazy.nvim` finishes downloading plugins.

- Delete the `.git` folder from the `nvim` folder:

  ```bash
  rm -rf ~/.config/nvim/.git
  ```

- Set a [**Nerd Font**](https://www.nerdfonts.com/) as your terminal font.
  - Recommended: **JetBrainsMono Nerd Font**
  - Install it using [`setup-fonts.sh`](../scripts/setup-fonts.sh).
  - After installation, select **JetBrainsMono Nerd Font** as your terminal font.
