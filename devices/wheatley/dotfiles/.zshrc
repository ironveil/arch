#
# zsh configuration
#


### WAYLAND

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec dbus-run-session Hyprland &>/dev/null
fi


### ZSH

# Enabe antigen & plugins
source /home/ironveil/.antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle sudo
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme crcandy

antigen apply


### ENV

# GPG
export GPG_TTY=$(tty)

# SSH
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/keyring/ssh


### ALAIS

# VS Code
alias code="code --enable-features=WaylandWindowDecorations,OzonePlatform --ozone-platform=wayland"