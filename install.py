#!/usr/bin/env python3

import os
import subprocess

files_str = "vimrc spacemacs.d agignore"
files = files_str.split()

from_prefix = "~/dotfiles/"
to_prefix   = "~/."

from_names = list(map(lambda x: os.path.expanduser(from_prefix + x), files))
to_names   = list(map(lambda x: os.path.expanduser(to_prefix + x),   files))

l = len(from_names)
commands = [*zip(["ln"] * l, ["-s"] * l, from_names, to_names)]

for cmd in commands:
    subprocess.call(cmd)
    # pprint.pprint(cmd)
