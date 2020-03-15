#!/usr/bin/env bash

function run {
    # run program [some arguments]
    # https://wiki.archlinux.org/index.php/Awesome#Autorun_programs
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run setxkbmap -option caps:swapescape
run xfce4-power-manager
run nm-applet     # network manager, using network-manager-gnome package
run fcitx
run albert
run urxvtd -q -o -f
# run xrdb $HOME/.Xresources