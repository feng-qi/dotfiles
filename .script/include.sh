#!/usr/bin/env bash

COLR_RED='\033[0;31m'
COLR_GREEN='\033[0;32m'
COLR_NC='\033[0m' # No Color

WARN='\033[0;31m[WARN]\033[0m'
INFO='\033[0;32m[INFO]\033[0m'

command_exists () {
    type "$1" &> /dev/null ;
}

package_installed () {
    dpkg -s "$1" &> /dev/null ;
    # dpkg-query -l "$1" &>/dev/null ;
}

install_utils() {
    local pkgs_str="git tree clang clang-format golang-any emacs25 zsh yakuake autoconf nmap net-tools
              jq konsole tmux tlp cmake cmake-curses-gui checkinstall vlc curl xclip exuberant-ctags
              vim-gui-common ibus-table-wubi ibus-pinyin chromium-browser command-not-found
              suckless-tools
              build-essential silversearcher-ag virtualenvwrapper qrencode xsel aria2 pv woof progress"
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

clone_repo_if_not_exist() {
    local source=$1
    local to_clone=$2
    shift 2
    if [ -e "${to_clone}" ]; then
        echo -e "${WARN} ${COLR_GREEN}${to_clone}${COLR_NC} already cloned! Skipped!"
    else
        git clone $@ "${source}" "${to_clone}"
    fi
}

clone_repo() {
    #                        clone_what                                 to_where
    clone_repo_if_not_exist "https://github.com/syl20bnr/spacemacs.git" "${HOME}/.spacemacs.d" --depth=1 -b develop
}

create_soft_link_if_not_exist() {
    local to_install=$1
    local source=$2
    if [ -h ${to_install} ]; then
        echo -e "${WARN} ${COLR_GREEN}${to_install}${COLR_NC} already exists! Skipped!"
    else
        ln -s "${source}" "${to_install}"
    fi
}

create_soft_link() {
    local files_str="zshrc vimrc agignore xmonad tmux.conf Xresources"
    local files=(${files_str})

    for file in ${files[@]}; do
        create_soft_link_if_not_exist "$HOME/.${file}" "$HOME/dotfiles/${file}"
    done

    #                              to_install           install_what
    create_soft_link_if_not_exist "$HOME/.config/nvim" "$HOME/dotfiles/nvim"
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
    if ! package_installed fasd ; then
        sudo add-apt-repository ppa:aacebedo/fasd
        sudo apt-get update
        sudo apt-get install fasd
    else
        echo -e "${WARN} fasd already installed!"
    fi

    # install fzf
    if ! [ -e "${HOME}/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && $HOME/.fzf/install
    else
        echo -e "${WARN} fzf already installed!"
    fi

    # include ubuntu-restricted-extras
    if ! package_installed ubuntu-restricted-extras ; then
        sudo apt install -y ubuntu-restricted-extras
    else
        echo -e "${WARN} ubuntu-restricted-extras already installed!"
    fi

    # install tomate: https://github.com/eliostvs/tomate-gtk
    # RELEASE=`sed -n 's/VERSION_ID="\(.*\)"/\1/p' /etc/os-release`
    # sudo wget -O- http://download.opensuse.org/repositories/home:/eliostvs:/tomate/xUbuntu_$RELEASE/Release.key | sudo apt-key add -
    # sudo bash -c "echo 'deb http://download.opensuse.org/repositories/home:/eliostvs:/tomate/xUbuntu_$RELEASE/ ./' > /etc/apt/sources.list.d/tomate.list"
    # sudo apt update
    # sudo apt install tomate-gtk
    # sudo apt install tomate-indicator-plugin
    # sudo apt install tomate-alarm-plugin
    # sudo apt install tomate-exec-plugin
}

install_awesome_wm() {
    # packages for Awesome wm
    sudo apt install -y awesome xautolock i3lock xfce4-power-manager imagemagick
    ln -s $HOME/dotfiles/awesome $HOME/.config/awesome
}
