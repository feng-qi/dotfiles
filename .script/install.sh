git clone --bare --depth=1 https://feng-qi@bitbucket.org/feng-qi/dotfiles.git $HOME/.git
function config { git --git-dir=$HOME/.git --work-tree=$HOME $@ }
mkdir -p .dotfile-backup
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