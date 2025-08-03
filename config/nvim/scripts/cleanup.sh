
#!/bin/bash

set -e

YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== SELECTIVELY REMOVING TOOLCHAIN INSTALLED FOR NEOVIM ===${NC}"

confirm() {
    read -p "Remove $1? [y/n]: " choice
    case "$choice" in
        y|Y ) return 0 ;;
        * ) return 1 ;;
    esac
}

# --- APT packages ---
if confirm "C/C++ tools (build-essential, clang)"; then
    sudo apt remove --purge -y build-essential clang
fi

if confirm "Java (openjdk-17-jdk)"; then
    sudo apt remove --purge -y openjdk-17-jdk
fi

if confirm "Lua (lua5.4)"; then
    sudo apt remove --purge -y lua5.4
fi

if confirm "Go (golang)"; then
    sudo apt remove --purge -y golang
fi

if confirm "Python (python3, pip3)"; then
    sudo apt remove --purge -y python3 python3-pip
fi

if confirm "Node.js and npm"; then
    sudo apt remove --purge -y nodejs npm
fi

if confirm "Neovim"; then
    sudo apt remove --purge -y neovim
fi

if confirm "Git"; then
    sudo apt remove --purge -y git
fi

sudo apt autoremove -y
sudo apt clean

# --- Rust ---
if [ -d "$HOME/.cargo" ] || [ -d "$HOME/.rustup" ]; then
    if confirm "Rust (rustup, cargo)"; then
        rustup self uninstall -y || true
        rm -rf "$HOME/.cargo" "$HOME/.rustup"
    fi
fi

rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/share/nvim"
