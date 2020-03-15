#!/usr/bin/env bash

set -o nounset
set -o errexit

source "$HOME/dotfiles/include.sh"

#----- main ----------

if [ $# -eq 0 ]; then
    echo -e "usage: $0 <arg> [arg ...]"
    echo -e "available argument:"
    echo -e "    base     basic utilities"
    echo -e "    libs     libraries"
    echo -e "    fonts    fonts, may take a while"
    echo -e "    link     links to appropriate targets"
    echo -e "    github   GitHub repositories"
    echo -e "    awesome  awesome Window Manager"
    echo -e "    miscs    miscellaneous stuff"
fi

while [ $# -gt 0 ]; do
    # echo $1
    # shift
    case "$1" in
        base)
            install_utils
            ;;
        libs)
            install_libs
            ;;
        fonts)
            install_fonts
            ;;
        link)
            create_soft_link
            ;;
        github)
            clone_repo
            ;;
        awesome)
            install_awesome_wm
            ;;
        miscs)
            install_miscs
            ;;
        *)
            echo -e "${WARN} Unrecognized Argument: ${COLR_RED}$1${COLR_NC}"
            exit 1
            ;;
    esac
    shift
done


# echo "source /etc/zsh_command_not_found" >> $HOME/.zshrc
# sudo update-command-not-found
