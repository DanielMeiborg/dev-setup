#!/bin/bash
# This shell script installs zsh, ohmyzsh, zsh-syntax-highlighting, zsh-autosuggestions, spaceship, nvchad, tmux

# ask for the package manager used. availabe options are pacman, apt and brew
echo "What package manager do you use?"
echo "[1] pacman"
echo "[2] apt"
echo "[3] brew"
read -p "Enter the number of the package manager you use: " package_manager

function install() {
    if [ $package_manager -eq 1 ]; then
        sudo pacman -S $1
    elif [ $package_manager -eq 2 ]; then
        sudo apt install $1
    elif [ $package_manager -eq 3 ]; then
        brew install $1
    else
        echo "Invalid package manager"
    fi
}

# install zsh and set as default shell
install zsh
