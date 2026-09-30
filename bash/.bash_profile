# Start Sway
if [[ -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" == 1 ]]; then
    exec sway
fi

# Load interactive Bash configuration
[[ -f ~/.bashrc ]] && source ~/.bashrc
