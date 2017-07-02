#!/usr/bin/env bash

set -o nounset
set -o errexit

command_exists () {
    type "$1" &> /dev/null ;
}

install_utils() {
    if ! command_exists ag ; then
        sudo apt-get install -y silversearcher-ag
    else
        echo "[WARN] ag already exists! Skipped!"
    fi
}

clone_repo() {
    if [ -e "$HOME/.vim/bundle/Vundle.vim" ]; then
        echo "[WARN] Vundle.vim already exists! Skipped!"
    else
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
}

create_soft_link() {
    files_str="vimrc spacemacs.d agignore"
    files=(${files_str})

    for file in ${files[@]}
    do
        if [ -e "$HOME/.${file}" ]; then
            echo "[WARN] Vundle.vim already exists! Skipped!"
        else
            ln -s "$HOME/dotfiles/${file}" "$HOME/.${file}"
        fi
    done
}

#----- main ----------

install_utils
clone_repo
create_soft_link
