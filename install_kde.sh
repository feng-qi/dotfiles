#!/usr/bin/env bash

set -o nounset
set -o errexit

source "$HOME/dotfiles/include.sh"

install_kde() {
    pkgs_str="kubuntu-desktop kubuntu-restricted-addons kubuntu-restricted-extras"
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

