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
            shift
            ;;
        libs)
            install_libs
            shift
            ;;
        fonts)
            install_fonts
            shift
            ;;
        link)
            create_soft_link
            shift
            ;;
        github)
            clone_repo
            shift
            ;;
        awesome)
            install_awesome_wm
            shift
            ;;
        miscs)
            install_miscs
            shift
            ;;
        *)
            echo -e "${WARN} Unrecognized Argument: ${COLR_RED}$1${COLR_NC}"
            exit 1
            ;;
    esac
done


# echo "source /etc/zsh_command_not_found" >> $HOME/.zshrc
# sudo update-command-not-found
