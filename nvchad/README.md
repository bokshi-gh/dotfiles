# NvChad

## References

* [**Docs**](https://nvchad.com/docs/quickstart/install)
* [**Tutorial**](https://youtu.be/Mtgo-nP_r8Y?si=zVTb6dbvyACUSGIl)

## Post-`setup.sh` Setup

### 1. Install and Configure a Nerd Font

Set a **Nerd Font** as your terminal font so that NvChad's icons and symbols render correctly.

Prefer a Nerd Font **without** the `Mono` suffix:

* ✅ `JetBrainsMono Nerd Font`
* ⚠️ `JetBrainsMono Nerd Font Mono`

The `Mono` variant also works, but its icons may appear slightly smaller.

Make sure the Nerd Font is installed and selected as your terminal's font.

### 2. Install Mason Packages

After `lazy.nvim` finishes downloading and installing the plugins, run:

```vim
:MasonInstallAll
```

### 3. Install Treesitter Parsers

Then run:

```vim
:TSInstallAll
```

These commands install the external tools and Treesitter parsers required by the configuration.

### 4. Remove the Git Repository

If this NvChad configuration was cloned from a repository and you want to use it as your own configuration, remove the `.git` directory from the `nvim` folder:

```bash
rm -rf ~/.config/nvim/.git
```

This removes the existing Git history and disconnects the configuration from the original repository.

This version is a little clearer and makes the **order of operations** explicit.
