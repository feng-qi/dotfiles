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
    local pkgs_str="git tree clang clang-format golang-any emacs25 zsh yakuake autoconf nmap net-tools
              konsole gnome-do gnome-pie tmux tlp cmake checkinstall vlc curl
              vim-gui-common ibus-table-wubi ibus-pinyin chromium-browser command-not-found
              build-essential silversearcher-ag"
    local pkgs=(${pkgs_str})

    for pkg in ${pkgs[@]}; do
        # if ! command_exists ${pkg} ; then
        if ! package_installed ${pkg} ; then
            echo -e "${INFO} ${COLR_GREEN}${pkg}${COLR_NC} installing"
            sudo apt install -y ${pkg}
            echo -e "${INFO} ${COLR_GREEN}${pkg}${COLR_NC} installed"
        else
            echo -e "${WARN} ${COLR_RED}${pkg}${COLR_NC} already exists! Skipped!"
        fi
    done
}

install_libs() {
    local libs_str="libclang-dev"
    local libs=(${libs_str})

    for lib in ${libs[@]}; do
        if ! package_installed ${lib} ; then
            echo -e "${INFO} ${COLR_GREEN}${lib}${COLR_NC} installing"
            sudo apt install -y ${lib}
            echo -e "${INFO} ${COLR_GREEN}${lib}${COLR_NC} installed successfully"
        else
            echo -e "${WARN} ${COLR_RED}${lib}${COLR_NC} already exists! Skipped!"
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
    local files_str="zshrc vimrc spacemacs.d agignore xmonad gitconfig"
    local files=(${files_str})

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

    # install tomate: https://github.com/eliostvs/tomate-gtk
    RELEASE=`sed -n 's/VERSION_ID="\(.*\)"/\1/p' /etc/os-release`
    sudo wget -O- http://download.opensuse.org/repositories/home:/eliostvs:/tomate/xUbuntu_$RELEASE/Release.key | sudo apt-key add -
    sudo bash -c "echo 'deb http://download.opensuse.org/repositories/home:/eliostvs:/tomate/xUbuntu_$RELEASE/ ./' > /etc/apt/sources.list.d/tomate.list"
    sudo apt update
    sudo apt install tomate-gtk
    sudo apt install tomate-indicator-plugin
    sudo apt install tomate-alarm-plugin
    sudo apt install tomate-exec-plugin
}

install_awesome_wm() {
    # packages for Awesome wm
    sudo apt install -y awesome xautolock i3lock xfce4-power-manager
    ln -s $HOME/dotfiles/awesome $HOME/.config/awesome
}
