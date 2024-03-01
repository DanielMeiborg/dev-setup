# Development Setup

This repository includes an install script and two Docker Containers (Ubuntu and Manjaro) to install some tools I commonly use in the terminal.
These include:
- zsh
- ohmyzsh
- zsh-syntax-highlighting
- zsh-autosuggestions
- spaceship
- zoxide
- nvchad
- tmux

It is meant to be a quick way to install a proper setup in a fresh vm or container. As it simply overrides every existing config it encounters, it should not be used on your main system.

It currently supports apt and pacman as package managers. It requires sudo, git and curl and base-devel/build-essential to be installed on the system. It should not be run as root but requires sudo privileges.

## curl-sh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DanielMeiborg/dev-setup/main/install.sh)"
```