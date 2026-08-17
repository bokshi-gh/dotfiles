# Dotfiles

Personal Linux configuration, shell utilities, editor configuration, and setup scripts.

## Structure

```text
.
├── bash
│   ├── .bashrc
│   ├── codeforces.sh
│   └── git.sh
├── docs
│   ├── nvchad.md
│   └── ssh.md
├── git
│   └── .gitconfig
├── .gitignore
├── nvchad
│   ├── README.md
│   └── scripts
│       ├── cleanup.sh
│       └── setup.sh
├── README.md
├── scripts
│   ├── cleanup-nvchad.sh
│   ├── cleanup.sh
│   ├── setup-fonts.sh
│   ├── setup-nvchad.sh
│   └── setup.sh
├── ssh
│   └── config
└── vim
    └── .vimrc
```

## Components

### Bash

The `bash/` directory contains Bash configuration and shell utilities.

* `.bashrc` — Main Bash configuration.
* `codeforces.sh` — Codeforces competitive programming workflow.
* `git.sh` — Git aliases and helper functions.

### Git

The `git/` directory contains the Git configuration:

```text
git/.gitconfig
```

It is linked to:

```text
~/.gitconfig
```

### Vim

The `vim/` directory contains the Vim configuration:

```text
vim/.vimrc
```

It is linked to:

```text
~/.vimrc
```

### SSH

The `ssh/` directory contains the SSH client configuration:

```text
ssh/config
```

It is linked to:

```text
~/.ssh/config
```

See [`docs/ssh.md`](docs/ssh.md) for more information.

### NvChad

The `nvchad/` directory contains the NvChad-specific setup and cleanup scripts.

See [`nvchad/README.md`](nvchad/README.md) for the NvChad setup.

Additional documentation is available in [`docs/nvchad.md`](docs/nvchad.md).

### Scripts

The `scripts/` directory contains general setup and cleanup scripts.

| Script              | Description               |
| ------------------- | ------------------------- |
| `setup.sh`          | Set up the dotfiles       |
| `cleanup.sh`        | Remove the dotfiles setup |
| `setup-fonts.sh`    | Set up fonts              |
| `setup-nvchad.sh`   | Set up NvChad             |
| `cleanup-nvchad.sh` | Clean up NvChad           |

## Setup

Clone the repository:

```bash
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Run the setup script:

```bash
./scripts/setup.sh
```

After setup, reload Bash:

```bash
source ~/.bashrc
```

Alternatively, open a new terminal.

## Cleanup

To remove the dotfiles configuration:

```bash
./scripts/cleanup.sh
```

The cleanup script removes the configuration symlinks managed by this repository and restores the previous configuration when a backup is available.

It does not remove personal projects or unrelated directories.

For example, the Codeforces workspace:

```text
~/Codeforces
```

is not managed or removed by the dotfiles cleanup.

## Codeforces Workflow

The Bash configuration provides a small `cf` command for competitive programming.

```text
Usage:
  cf init <contest_id>                   Initialize a contest
  cf new <problem_index>                 Create a single-test solution file
  cf new <problem_index> [-t | --tests]  Create a multi-test solution file
  cf run <problem_index>                 Compile and run a solution
```

Example:

```bash
cf init 2000
cf new A
cf new B -t
cf run A
```

This creates a workspace such as:

```text
~/Codeforces/
└── 2000/
    ├── A.cpp
    └── B.cpp
```

`cf new` creates and opens the solution in Neovim.

`cf run` compiles the solution using `g++` with C++20 and optimization/warning flags, then runs it.

## Documentation

Additional documentation:

* [`docs/nvchad.md`](docs/nvchad.md) — NvChad notes and setup.
* [`docs/ssh.md`](docs/ssh.md) — SSH configuration notes.
* [`nvchad/README.md`](nvchad/README.md) — NvChad-specific setup.

## Notes

This repository contains personal configuration and workflow scripts for a Linux development environment.

The configuration files are kept separate from setup scripts and documentation so individual components can be managed independently.
