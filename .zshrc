# Prevent repeated loading
[[ -z "$_INIT_SH_LOADED" ]] && _INIT_SH_LOADED=1 || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export PATH="$PATH:$HOME/.local/bin:/snap/bin"

# Delete duplicated path
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
            *:"$x":*) ;;
            *) PATH=$PATH:$x;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi
export PATH

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE"
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE"
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi


function __command_exists () { command -v "$1" &> /dev/null; }

# Load local bash/zsh compatible settings
_INIT_SH_NOFUN=1
[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# exit for non-interactive shell
[[ $- != *i* ]] && return

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE


# Initialize antigen
source "$ANTIGEN"


# Initialize oh-my-zsh
antigen use oh-my-zsh

# default bundles
# visit https://github.com/unixorn/awesome-zsh-plugins
# antigen bundle rupa/z z.sh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle Vifon/deer

# uncomment the line below to enable theme
# antigen theme fishy


# check login shell
if [[ -o login ]]; then
    [ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
    [ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# setup for deer
autoload -U deer
zle -N deer
bindkey '\ev' deer


# default keymap
# bindkey -s '\ee' 'vim\n'
# bindkey '\eh' backward-char
# bindkey '\el' forward-char
# bindkey '\ej' down-line-or-history
# bindkey '\ek' up-line-or-history
# bindkey '\eu' undo
# bindkey '\eH' backward-word
# bindkey '\eL' forward-word
# bindkey '\eJ' beginning-of-line
# bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'
bindkey -s '\er' '_INIT_SH_LOADED=""; source $HOME/.zshrc\n'
bindkey -r "^[l"

# bindkey '\e[1;3D' backward-word
# bindkey '\e[1;3C' forward-word
# bindkey '\e[1;3A' beginning-of-line
# bindkey '\e[1;3B' end-of-line

alias g=git
alias ga='git add'
alias gaa='git add --all'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gcl='git clone'
alias gl='git pull'
alias gp='git push'
alias glol='git lol'
alias glola='git lola'
alias gco='git checkout'
alias gcm='git checkout master'
alias gcmsg='git commit -m'

# alias s='ssh -l fengqi -p 10020 -J jump.hk'
# alias d='docker run --rm -v ~/bigo:/home/qi/bigo --workdir /home/qi/bigo --user $(id -u):$(id -g) -it compile_base bash'
alias lg='ls | grep -E'

function config { git --git-dir=$HOME/.git --work-tree=$HOME $@; }

# options
unsetopt correct_all

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt extendedglob


# source function.sh if it exists
# [ -f "$HOME/.local/etc/function.sh" ] && . "$HOME/.local/etc/function.sh"


# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
zstyle ':completion:*:*sh:*:' tag-order files

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

# python
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/pyprojects

# rust
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup'
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env" || true

# # llvm
# export PATH="$HOME/test/llvm/install/bin:$PATH"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/test/llvm/install/lib"

# go
if __command_exists go; then
    export GOPATH="$HOME/test/go"
    export PATH="$PATH:$GOPATH/bin"
fi

# Idris
[ -d "$HOME/.cabal/bin" ] && export PATH="$PATH:$HOME/.cabal/bin" || true

# # clojure boot
# export BOOT_JVM_OPTIONS='--add-modules java.xml.bind'

# java
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export PATH=$JAVA_HOME/bin:$PATH

# Initialize command prompt
# http://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " %{$fg[blue]%}(%b)%{$reset_color%}"
precmd() { vcs_info }
setopt prompt_subst
export PS1='%F{cyan}%n%F{yellow}@%F{cyan}%~%f${vcs_info_msg_0_}%(1j. %F{red}<%j>%f.) %B%(?.%F{green}%#%f.%F{red}%#%f)%b '

# autoload -Uz promptinit && promptinit
# prompt adam1

[[ -e /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found

dtouch () {
    for file in $@; do
        mkdir -p "$(dirname "$file")"
        touch $file
    done
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true