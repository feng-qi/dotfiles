#!/usr/bin/env bash

set -o nounset
set -o errexit

source "$HOME/dotfiles/include.sh"

#----- main ----------

while [ $# -gt 0 ]; do
    # echo $1
    # shift
    case "$1" in
        base)
            install_utils
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
        *)
            echo -e "${WARN} Unrecognized Argument: ${COLR_RED}$1${COLR_NC}"
            exit 1
            ;;
    esac
done


# echo "source /etc/zsh_command_not_found" >> $HOME/.zshrc
# sudo update-command-not-found
