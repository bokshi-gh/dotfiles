Yes, this is better. I’d just make the headings consistent and put the recommended font directly under the Nerd Font heading:

# NvChad

## References

* [**Docs**](https://nvchad.com/docs/quickstart/install)
* [**Tutorial**](https://youtu.be/Mtgo-nP_r8Y?si=zVTb6dbvyACUSGIl)

## Post [setup.sh](./scripts/setup.sh)

### [Nerd Font](https://www.nerdfonts.com/) as Your Terminal Font

Recommended: **JetBrainsMono Nerd Font**

### Run `:MasonInstallAll` and `:TSInstallAll`

Run these commands after `lazy.nvim` finishes downloading plugins:

```vim
:MasonInstallAll
:TSInstallAll
```

### Delete the `.git` Folder

```bash
rm -rf ~/.config/nvim/.git
```
