#!/bin/bash
# This shell script installs zsh, ohmyzsh, zsh-syntax-highlighting, zsh-autosuggestions, spaceship, zoxide, nvchad, tmux

if [ "$EUID" -eq 0 ]; then
    echo "Do not run as root"
    exit 1
fi

# -y flag to automatically install packages
if [ "$2" != "y" ]; then
    echo "ATTENTION! This script will overwrite a lot of existing configurations and can break stuff."
    read -p "Continue? (y/N): " choice
    choice=$(echo $choice | tr '[:upper:]' '[:lower:]')
    if [ $choice != "y" ]; then
        echo "Exiting"
        exit 1
    fi
fi

# ask for the package manager used. availabe options are pacman, apt and brew
if [ $1 ]; then
    package_manager=$1
else
    echo "What package manager do you use? \n   pacman \n   apt"
    read -p "Enter the package manager you use: " package_manager
    package_manager=$(echo $package_manager | tr '[:upper:]' '[:lower:]')
fi

echo "Using $package_manager"

install() {
    if [ "$package_manager" = "pacman" ]; then
        sudo pacman -S $1 --noconfirm
    elif [ "$package_manager" = "apt" ]; then
        sudo apt install -y $1
    else
        echo "Invalid package manager"
    fi
}

anounce() {
    echo ""
    echo "----------------------------------------"
    # in color red and all caps
    echo -e "Installing \e[1;31m$1\e[0m"
    echo ""
}

touch ~/.zshrc

echo '
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"
plugins=(zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias home="cd ~ && clear"
alias cd="z"
alias ll="ls -al"

mkdircd() {
    mkdir $1 && cd $1
}

eval "$(zoxide init zsh)"
' >~/.zshrc

anounce "zsh"
install zsh

anounce "oh-my-zsh"
KEEP_ZSHRC="yes" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

anounce "zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

anounce "zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

anounce "spaceship"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

anounce "zoxide"
install zoxide

anounce "nvchad"
install neovim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

mkdir -p ~/.config/tmux

touch ~/.config/tmux/tmux.conf
echo '
set-option -sa terminal-overrides ",xterm*:Tc"
set -g mouse on

unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

bind -n S-Left previous-window
bind -n S-Right next-window

bind -n M-H previous-window
bind -n M-L next-window

set -g @catppuccin_flavour "mocha"

set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "dreamsofcode-io/catppuccin-tmux"
set -g @plugin "tmux-plugins/tmux-yank"

set -g @catppuccin_user "on"
set -g @catppuccin_host "on"

run "~/.tmux/plugins/tpm/tpm"

bind % split-window -v -c "#{pane_current_path}"

set -g default-shell' "$(which zsh)"
>~/.config/tmux/tmux.conf

anounce "tmux"
install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

chsh -s $(which zsh) $USER

source ~/.zshrc
echo ""
echo "----------------------------------------"
echo "Installation complete"
