git clone --bare https://gitee.com/feng-qi/dotfiles.git $HOME/dotfiles
function config { git --git-dir=$HOME/dotfiles --work-tree=$HOME $@; }
mkdir -p .dotfile-backup/{,.config}
echo "Checking out dotfiles ..."
if config checkout; then
    echo "Done checking out dotfiles"
else
    echo "Backing up existing dot files ..."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfile-backup/{}
    echo "Done backing up existing dot files"
    config checkout
    echo "Done checking out dotfiles"
fi
config config status.showUntrackedFiles no
