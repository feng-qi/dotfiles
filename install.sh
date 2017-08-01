#!/usr/bin/env bash

set -o nounset
set -o errexit

COLR_RED='\033[0;31m'
COLR_GREEN='\033[0;32m'
COLR_NC='\033[0m' # No Color

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
    files_str="vimrc spacemacs.d agignore xmonad"
    files=(${files_str})

    for file in ${files[@]}
    do
        if [ -e "$HOME/.${file}" ]; then
            echo -e "[WARN] ${COLR_GREEN}${file}${COLR_NC} already exists! Skipped!" # -e is necessary
            # printf "[WARN] ${COLR_GREEN}${file}${COLR_NC} already exists! Skipped!\n"
        else
            ln -s "$HOME/dotfiles/${file}" "$HOME/.${file}"
        fi
    done
}

#----- main ----------

install_utils
clone_repo
create_soft_link
