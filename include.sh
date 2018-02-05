#!/usr/bin/env bash

COLR_RED='\033[0;31m'
COLR_GREEN='\033[0;32m'
COLR_NC='\033[0m' # No Color

WARN='\033[0;31m[WARN]\033[0m'
INFO='\033[0;32m[WARN]\033[0m'

command_exists () {
    type "$1" &> /dev/null ;
}

package_installed () {
    dpkg -s "$1" &> /dev/null ;
    # dpkg-query -l "$1" &>/dev/null ;
}

install_utils() {
    pkgs_str="git tree clang clang-format golang-any emacs25 zsh yakuake autoconf nmap net-tools
              vim-gui-common i3-wm ibus-table-wubi ibus-pinyin chromium-browser command-not-found
              build-essential silversearcher-ag"
    pkgs=(${pkgs_str})

    for pkg in ${pkgs[@]}; do
        # if ! command_exists ${pkg} ; then
        if ! package_installed ${pkg} ; then
            # sudo apt-get install -y silversearcher-ag
            # echo -e "${INFO} ${COLR_GREEN}${pkg}${COLR_NC} will be installed."
            sudo apt install -y ${pkg}
        else
            echo -e "${WARN} ${COLR_RED}${pkg}${COLR_NC} already exists! Skipped!"
        fi
    done
}

clone_repo() {
    if [ -e "$HOME/.vim/bundle/Vundle.vim" ]; then
        echo -e "${WARN} ${COLR_GREEN}Vundle.vim${COLR_NC} already exists! Skipped!"
    else
        git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
    fi
}

create_soft_link() {
    files_str="vimrc spacemacs.d agignore xmonad gitconfig"
    files=(${files_str})

    for file in ${files[@]}
    do
        if [ -e "$HOME/.${file}" ]; then
            echo -e "${WARN} ${COLR_GREEN}${file}${COLR_NC} already exists! Skipped!" # -e is necessary
            # printf "${WARN} ${COLR_GREEN}${file}${COLR_NC} already exists! Skipped!\n"
        else
            ln -s "$HOME/dotfiles/${file}" "$HOME/.${file}"
        fi
    done
}

install_fonts() {
    if ! [ -e "${HOME}/github/fonts" ]; then
        git clone feng-qi@bitbucket.org:feng-qi/fonts.git ${HOME}/github/fonts
    fi

    if [ -e "/usr/local/share/fonts/source_code_pro" ]; then
        echo -e "${WARN} fonts already installed!"
    else
        sudo mkdir /usr/local/share/fonts/source_code_pro
        sudo cp ${HOME}/github/fonts/source-code-pro/* /usr/local/share/fonts/source_code_pro
        sudo mkdir /usr/local/share/fonts/adobe
        sudo cp ${HOME}/github/fonts/adobe/* /usr/local/share/fonts/adobe
        fc-cache -fv
        echo -e "${INFO} fonts installed."
    fi
}

install_miscs() {
    # install fasd
    sudo add-apt-repository ppa:aacebedo/fasd
    sudo apt-get update
    sudo apt-get install fasd

    # install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # include ubuntu-restricted-extras
    sudo apt install -y ubuntu-restricted-extras

    # packages for Awesome wm
    sudo apt install -y awesome xautolock i3lock xfce4-power-manager
    ln -s $HOME/dotfiles/awesome $HOME/.config/awesome
}