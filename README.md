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

It currently supports apt and pacman as package managers. It requires sudo, git and curl and base-devel/build-essential to be installed on the system.

To curl-sh the install script, run the following command in your terminal:
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/DanielMeiborg/dev-setup/main/install.sh)"
```