git clone --bare https://gitee.com/feng-qi/dotfiles.git $HOME/.git || exit 1
function config { git --git-dir=$HOME/.git --work-tree=$HOME $@; }
echo "Checking out dotfiles ..."
if config checkout; then
    echo "Done checking out dotfiles"
else
    echo "Backing up existing dot files ..."
    if [ -e $HOME/.dotfile-backup ]; then
        echo "$HOME/.dotfile-backup already exists, can't backup files"
        exit 2
    fi
    mkdir -p $HOME/.dotfile-backup/{,.config,.script,.xmonad}
    mkdir -p $HOME/.dotfile-backup/.config/{awesome,i3,nvim}
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv $HOME/{} $HOME/.dotfile-backup/{}
    if [ -e $HOME/README.md ]; then mv $HOME/README.md $HOME/.dotfile-backup; fi
    echo "Done backing up existing dot files"
    config checkout
    echo "Done checking out dotfiles"
fi
config config status.showUntrackedFiles no
config config --bool core.bare false
