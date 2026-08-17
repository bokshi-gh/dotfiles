# Dotfiles

Personal Linux configuration, development tools, and workflow scripts.

## Repository Structure

```text
.
├── bash/
│   ├── .bashrc
│   ├── codeforces.sh
│   └── git.sh
├── git/
│   └── .gitconfig
├── vim/
│   └── .vimrc
├── ssh/
│   └── config
├── scripts/
│   ├── cleanup-nvchad.sh
│   ├── cleanup.sh
│   ├── setup-fonts.sh
│   ├── setup-nvchad.sh
│   └── setup.sh
├── docs/
│   ├── nvchad.md
│   └── ssh.md
├── .gitignore
└── README.md
```

## Directory Overview

### `bash/`

Contains the Bash configuration and shell utilities.

```text
bash/
├── .bashrc
├── codeforces.sh
└── git.sh
```

* `.bashrc` — Main Bash configuration, environment variables, aliases, functions, and shell settings.
* `codeforces.sh` — Codeforces workflow for creating, compiling, and running C++ solutions.
* `git.sh` — Git aliases and helper functions.

The `.bashrc` sources the additional Bash scripts so their commands are available in interactive shells.

### `git/`

Contains the Git configuration.

```text
git/
└── .gitconfig
```

The configuration is linked to:

```text
~/.gitconfig
```

### `vim/`

Contains the Vim configuration.

```text
vim/
└── .vimrc
```

The configuration is linked to:

```text
~/.vimrc
```

### `ssh/`

Contains the SSH client configuration.

```text
ssh/
└── config
```

The configuration is linked to:

```text
~/.ssh/config
```

See [`docs/ssh.md`](docs/ssh.md) for additional information.

### `scripts/`

Contains scripts for setting up and cleaning up the environment.

```text
scripts/
├── cleanup-nvchad.sh
├── cleanup.sh
├── setup-fonts.sh
├── setup-nvchad.sh
└── setup.sh
```

| Script              | Purpose                   |
| ------------------- | ------------------------- |
| `setup.sh`          | Set up the dotfiles       |
| `cleanup.sh`        | Remove the dotfiles setup |
| `setup-fonts.sh`    | Set up fonts              |
| `setup-nvchad.sh`   | Set up NvChad             |
| `cleanup-nvchad.sh` | Clean up NvChad           |

### `docs/`

Contains additional documentation.

```text
docs/
├── nvchad.md
└── ssh.md
```

* `nvchad.md` — NvChad setup and configuration notes.
* `ssh.md` — SSH configuration notes.

---

## Setup

Clone the repository:

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Run the main setup script:

```bash
./scripts/setup.sh
```

After setup, reload Bash:

```bash
source ~/.bashrc
```

Or open a new terminal.

## Configuration Links

The setup script links the repository configurations to their standard locations:

```text
~/dotfiles/bash/.bashrc
        ↓
~/.bashrc

~/dotfiles/git/.gitconfig
        ↓
~/.gitconfig

~/dotfiles/vim/.vimrc
        ↓
~/.vimrc

~/dotfiles/ssh/config
        ↓
~/.ssh/config
```

This keeps the configuration files inside the repository while applications continue using their normal configuration paths.

---

## Codeforces Workflow

The Bash configuration provides a `cf` command for competitive programming.

```text
Usage:
  cf init <contest_id>                   Initialize a contest
  cf new <problem_index>                 Create a single-test solution file
  cf new <problem_index> [-t | --tests]  Create a multi-test solution file
  cf run <problem_index>                 Compile and run a solution
```

### Initialize a Contest

```bash
cf init 2000
```

Creates and enters:

```text
~/Codeforces/2000/
```

### Create a Solution

For a problem without multiple test cases:

```bash
cf new A
```

For a problem with multiple test cases:

```bash
cf new B -t
```

or:

```bash
cf new B --tests
```

The solution file is created and immediately opened in Neovim.

### Run a Solution

```bash
cf run A
```

The solution is compiled with `g++` using C++20, optimization, and warning flags, then executed.

### Codeforces Directory

Codeforces workspaces are kept outside this repository:

```text
~/Codeforces/
└── 2000/
    ├── A.cpp
    └── B.cpp
```

The dotfiles setup and cleanup scripts do not manage or remove `~/Codeforces`.

---

## Cleanup

To remove the dotfiles setup:

```bash
./scripts/cleanup.sh
```

The cleanup script:

* Removes configuration symlinks managed by this repository.
* Restores previous configuration files from `.backup` files when available.
* Does not remove unrelated files.
* Does not remove personal projects or the Codeforces workspace.

---

## Documentation

Additional documentation:

* [`docs/ssh.md`](docs/ssh.md) — SSH configuration notes.
* [`docs/nvchad.md`](docs/nvchad.md) — NvChad setup and configuration notes.

## Notes

This repository contains personal configuration and workflow scripts for a Linux development environment.

The configuration files are kept separate from setup scripts and documentation so individual components can be managed independently.
