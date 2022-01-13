# Prevent repeated loading
[[ -z "$_INIT_SH_LOADED" ]] && _INIT_SH_LOADED=1 || return
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

## ------ Plugin setup begin ------
# https://github.com/mattmc3/zsh_unplugged
# $plugin_name.plugin.zsh(N) uses NULL_GLOB option
# clone a plugin, find an init.zsh, source it, and add it to your fpath
function plugin-load () {
    local giturl="$1"
    local plugin_name=${${giturl##*/}%.git}
    local plugindir="${ZPLUGINDIR:-$HOME/.zsh/plugins}/$plugin_name"

    # clone if the plugin isn't there already
    if [[ ! -d $plugindir ]]; then
        command git clone --depth 1 --recursive --shallow-submodules $giturl $plugindir
        if [[ $? -ne 0 ]]; then
            echo "plugin-load: git clone failed for: $giturl" >&2 && return 1
        fi
    fi

    # symlink an init.zsh if there isn't one so the plugin is easy to source
    if [[ ! -f $plugindir/init.zsh ]]; then
        local initfiles=(
            # look for specific files first
            $plugindir/$plugin_name.plugin.zsh(N)
            $plugindir/$plugin_name.zsh(N)
            $plugindir/$plugin_name(N)
            $plugindir/$plugin_name.zsh-theme(N)
            # then do more aggressive globbing
            $plugindir/*.plugin.zsh(N)
            $plugindir/*.zsh(N)
            $plugindir/*.zsh-theme(N)
            $plugindir/*.sh(N)
        )
        if [[ ${#initfiles[@]} -eq 0 ]]; then
            echo "plugin-load: no plugin init file found" >&2 && return 1
        fi
        command ln -s ${initfiles[1]} $plugindir/init.zsh
    fi

    # source the plugin
    source $plugindir/init.zsh

    # modify fpath
    fpath+=$plugindir
    [[ -d $plugindir/functions ]] && fpath+=$plugindir/functions
}

function plugin-update () {
    local plugindir="${ZPLUGINDIR:-$HOME/.zsh/plugins}"
    for d in $plugindir/*/.git(/); do
        echo "Updating ${d:h:t}..."
        command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    done
}

# set where we should store Zsh plugins
ZPLUGINDIR=$HOME/.zsh/plugins
plugin-load https://github.com/zsh-users/zsh-autosuggestions.git
plugin-load https://github.com/zsh-users/zsh-syntax-highlighting.git

## ------ Plugin setup end ------

function __command_exists () { command -v "$1" &> /dev/null; }
function ygd { git diff $@ | ydiff -s }
function config { git --git-dir=$HOME/dotfiles --work-tree=$HOME $@; }
function take { mkdir -p $@ && cd ${@:$#} }
function dpkgS () { dpkg -S $(command -v "$1"); }

HISTFILE=~/.zhistory
HISTSIZE=5000
SAVEHIST=5000

# setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt extendedglob
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY
unsetopt SHARE_HISTORY
# setopt SHARE_HISTORY             # Share history between all sessions.

# Initialize command prompt
# http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " %{$fg[blue]%}(%b)%{$reset_color%}"

# https://www.nikhita.dev/automate-display-of-time-taken-by-command
# https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds/29269811#29269811
function preexec() { _timer=${timer:-$SECONDS} }
function precmd() {
    if [ $_timer ]; then
        # export timer_show=" $(date -d@$(($SECONDS - $_timer)) -u +%H:%M:%S)"
        # export RPROMPT="%F{cyan}${timer_show}%{$reset_color%}"
        ((_seconds = $SECONDS - $_timer))
        export timer_show=" $((_seconds/3600)):$((_seconds%3600/60)):$((_seconds%60))"
        unset _timer
    fi
    vcs_info
}

setopt prompt_subst
export PS1='%F{cyan}%n%F{yellow}@%m%F{magenta}${MACHTYPE/x86_64}:%F{cyan}%~%f${timer_show}${vcs_info_msg_0_}%(1j. %F{red}<%j>%f.) %B%(?.%F{green}%#%f.%F{red}%? %#%f)%b '
export WORDCHARS='*?.[]~=&;!#$%^(){}<>'

# https://unix.stackexchange.com/questions/341271/dircolors-myfile-sets-ls-colors-to-empty-string-in-screen
export TERM=xterm-256color
# https://unix.stackexchange.com/questions/94299/dircolors-modify-color-settings-globaly
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# https://gist.github.com/nhibberd/9d78576aab943cdb0f6c
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

. "$HOME/.script/alias.sh"

alias d='docker run --user $(id -u):$(id -g) -tid -e ARMFVP_BIN_PATH=/fvp/11.14.28 -e LM_LICENSE_FILE=7010@euhpc-lic03.euhpc.arm.com -v $HOME/zephyrproject:/workdir -v $HOME/fvp/11.14.28/:/fvp/11.14.28 -w=/workdir/zephyr --name zephyr docker.io/zephyrprojectrtos/zephyr-build:latest'
alias dr='docker exec -ti zephyr'
# docker exec -ti -w=/workdir/twister-outs zephyr bash -c 'source /workdir/zephyr/zephyr-env.sh && twister -p fvp_baser_aemv8r'
# docker exec -ti -w=/workdir/twister-outs zephyr bash -c 'source /workdir/zephyr/zephyr-env.sh && west build -p always -b fvp_baser_aemv8r /workdir/zephyr/samples/hello_world/'
alias droot='docker exec --user root -ti zephyr bash'

export PATH="$HOME/github/emacs/lib-src:$HOME/github/emacs/src:$PATH:/usr/lib/cargo/bin"

# radare2
[ -f "$HOME/bin/radare2" ] && export PATH="$PATH:$HOME/bin" || true

# go
if __command_exists go; then
    export GOPATH="$HOME/test/go"
    export PATH="$PATH:$GOPATH/bin"
fi

# # Idris
# [ -d "$HOME/.cabal/bin" ] && export PATH="$PATH:$HOME/.cabal/bin" || true

# python
export WORKON_HOME=~/.virtualenv
export PROJECT_HOME=~/pyprojects

# llvm
# export LD_LIBRARY_PATH="$HOME/install/llvm/lib"
[ -d "$HOME/install/llvm/bin" ] && export PATH="$HOME/install/llvm/bin:$PATH" || true

# # rust
# export RUSTUP_DIST_SERVER='https://mirrors.tuna.tsinghua.edu.cn/rustup'
# [ -f "$HOME/.cargo/env" ] && export PATH="$HOME/.cargo/bin:$PATH" || true

# haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# nodejs
[ -d "$HOME/install/node/bin" ] && export PATH="$HOME/install/node/bin:$PATH" || true

[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh || true

# # Remove duplicates in zsh $PATH
# # https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
# typeset -aU path

# # time-consuming operations, do them manually when needed
# [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ] && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh || true
# plugin-load https://github.com/zsh-users/zsh-completions.git && autoload -U compinit && compinit

