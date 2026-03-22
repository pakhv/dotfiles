#!/usr/bin/bash

home_path="/home/pakhv"

if [[ ! -z $1 ]]; then
    home_path=$1
fi

# .zshrc
echo 'symlink for .zshrc'
ln -sf "${home_path}/dotfiles/zsh/.zshrc" "${home_path}/.zshrc"

# .tmux.conf
echo 'symlink for .tmux.conf'
ln -sf "${home_path}/dotfiles/tmux/.tmux.conf" "${home_path}/.tmux.conf"

# autosuggestions and highlights
mkdir -p "${home_path}/.zsh"

if [[ ! -d "${home_path}/.zsh/zsh-autosuggestions" ]]; then
    echo 'cloning zsh-autosuggestions'
    git clone https://github.com/zsh-users/zsh-autosuggestions "${home_path}/.zsh/zsh-autosuggestions"
fi

if [[ ! -d "${home_path}/.zsh/zsh-syntax-highlighting" ]]; then
    echo 'cloning zsh-syntx-highlighting'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${home_path}/.zsh/zsh-syntax-highlighting"
fi

# scripts
echo 'symlink for scripts'
mkdir -p "${home_path}/.local"
ln -sf "${home_path}/dotfiles/scripts" "${home_path}/.local"

# i3wm
echo 'symlink for i3'
mkdir -p "${home_path}/.config/i3"
ln -sf "${home_path}/dotfiles/i3/config" "${home_path}/.config/i3/config"

# tmux catppuccin
mkdir -p "${home_path}/tmux/catppuccin"

if [[ ! -d "${home_path}/tmux/catppuccin/tmux" ]]; then
    echo 'cloning tmux catppuccin theme'
    git clone https://github.com/catppuccin/tmux.git "${home_path}/tmux/catppuccin/tmux"
fi

# nvim config
echo 'symlink for nvim config'
ln -sf "${home_path}/dotfiles/nvim" "${home_path}/.config/nvim"

#install zsh, tmux, fzf, ripgrep
