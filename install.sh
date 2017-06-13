#!/usr/bin/env bash

files_str="vimrc spacemacs.d agignore"
files=(${files_str})
FROM_DIR="~/dotfiles"
TO_DIR="~"

for file in ${files[@]}
do
    # echo ${FROM_DIR}/${file} ${TO_DIR}/"."${file}
    ln -s ${FROM_DIR}/${file} ${TO_DIR}/"."${file}
done
