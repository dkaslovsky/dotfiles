export BROWSER='Brave Browser'

######
# ls #
######
alias ls='ls -lhFG'
alias lsa='ls -lahFG'


#######
# Git #
#######
export EDITOR='vim'
alias gits='git status'


######
# Go #
######
export GOPATH=$HOME/code/go
alias cdgo="cd ${GOPATH}"
alias cdgosrc="cd ${GOPATH}/src"
alias cdgogit="cd ${GOPATH}/src/github.com"
alias cdgodk="cd ${GOPATH}/src/github.com/dkaslovsky"
alias pprof='go tool pprof -http 127.0.0.1:9999'


##########
# Gopass #
##########
export GOPASS_BROWSER="${BROWSER}"
# export _gopass_custom_config=$HOME/dotfiles/funcs/gopass/gopass_config
# export GOPASS_NO_AUTOSYNC=true


#######
# GPG #
#######
export GPG_TTY=$(tty)
alias gpglock='gpgconf --kill gpg-agent'
defaults write org.gpgtools.common UseKeychain NO


###########
# tabgrab #
###########
export TABGRAB_BROWSER="brave"
export TABGRAB_BROWSER_ARGS="--profile-directory=Default"


###############
# scratch dir #
###############
export SCRATCH_DIR="${HOME}/scratch"
if [ ! -d $SCRATCH_DIR ]; then
    mkdir -p $SCRATCH_DIR
fi


#############################
# hotkey launchctl startup #
############################
hotkeys_restart() {
    launchctl stop com.dkas.hotkeys
    sleep 2
    launchctl start com.dkas.hotkeys
}


#######
# fzf #
#######

#-------------
# the following lines are from .fzf.zsh which is generated by running $(brew --prefix)/opt/fzf/install
if [ -d "/opt/homebrew" ]; then
    # Setup fzf
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
      export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi
    # Auto-completion
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
    # Key bindings
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
else
    # Setup fzf
    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
      export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
    fi
    # Auto-completion
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
    # Key bindings
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi
#-------------

# use alt-c
bindkey "ç" fzf-cd-widget

# set default options
# see: https://betterprogramming.pub/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && cat {}) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
"

# optionally use fd or rg
FZF_USE_FD=true
FZF_USE_RG=false

if $FZF_USE_FD; then
    export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
    _fzf_compgen_path() {
        fd . "$1"
    }
    _fzf_compgen_dir() {
        fd --type d . "$1"
    }
fi

if $FZF_USE_RG; then
    export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND | xargs gdirname | sort | uniq"

    _rg_cmd() {
        rg --files --hidden --glob '!.git'
    }
    _fzf_compgen_path() {
        _rg_cmd
    }
    _fzf_compgen_dir() {
        _rg_cmd | xargs gdirname | sort | uniq
    }
fi


#######
# k8s #
#######
alias kc='kubectl'


##########
# Python #
##########
export PIP_REQUIRE_VIRTUALENV=true


##########
# MyMint #
##########
export MYMINT_CONF_DIR=~/.mymint


############
# textnote #
############
alias tn='textnote'
export TEXTNOTE_DIR=~/.textnote


##################
# calendar-tasks #
##################
export CALENDAR_TASKS_DIR=~/.calendar-tasks
export CALENDAR_TASKS_WEEKLY_SOURCES="$CALENDAR_TASKS_DIR/sources/weekly.txt"
export CALENDAR_TASKS_MONTHLY_SOURCES="$CALENDAR_TASKS_DIR/sources/monthly.txt"
export CALENDAR_TASKS_ANNUAL_SOURCES="$CALENDAR_TASKS_DIR/sources/annual.txt,$CALENDAR_TASKS_DIR/sources/annual_multiple.txt"
export CALENDAR_TASKS_SINGLE_SOURCES="$CALENDAR_TASKS_DIR/sources/single.txt"
alias ct="calendar-tasks"


#############
# thread-safe
#############
export THREAD_SAFE_PATH=~/Documents/threads


#######
# nav #
#######
alias nav='nav --remap-esc ";;"'


###########
# VS Code #
###########
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'


#######################
# Source custom funcs #
#######################
. ~/dotfiles/funcs/browser
. ~/dotfiles/funcs/cmdline
. ~/dotfiles/funcs/calendartasks
. ~/dotfiles/funcs/jn
. ~/dotfiles/funcs/git/git_funcs
. ~/dotfiles/funcs/github
. ~/dotfiles/funcs/go
. ~/dotfiles/funcs/gopass/gopass_funcs
. ~/dotfiles/funcs/gpg
. ~/dotfiles/funcs/logitech
. ~/dotfiles/funcs/metabase
. ~/dotfiles/funcs/mymint
. ~/dotfiles/funcs/nav
. ~/dotfiles/funcs/python/newvenv
. ~/dotfiles/funcs/python/pycheck
. ~/dotfiles/funcs/rg
. ~/dotfiles/funcs/sdrive
. ~/dotfiles/funcs/sql/sql
. ~/dotfiles/funcs/textnote
. ~/dotfiles/funcs/threadsafe
. ~/dotfiles/funcs/vscode

if [[ -d ~/dotfiles/private ]]; then
	. ~/dotfiles/private/private
fi
if [[ -d ~/dotfiles/work ]]; then
	. ~/dotfiles/work/work
fi
if [[ -d ~/.work-private ]]; then
    . ~/.work-private/work-private
fi


##################
# Command Prompt #
##################
setopt PROMPT_SUBST
PROMPT='%(?^%F{cyan}[%n@%m] [%2~]$(git_branch)%f^%F{red}[%n@%m] [%2~]$(git_branch)%f) $(git_dotfiles)$ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


########
# PATH #
########
PTH=$HOME/bin:$GOPATH/bin
if [ -d "/opt/homebrew" ]; then
    PTH=$PTH:/opt/homebrew/bin
fi
if [ -d "/Applications/Postgres.app/Contents/Versions/latest" ]; then
    PTH=$PTH:/Applications/Postgres.app/Contents/Versions/latest/bin
fi
export PATH=$PTH:$PATH
unset PTH


############
# ZSH OPTS #
############

# don't display trailing EOL mark (%) on partial line
export PROMPT_EOL_MARK=''

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# write history with timestamp
setopt EXTENDED_HISTORY
# verify previous command (!!)
setopt HIST_VERIFY

# list but don't replace globs
setopt GLOB_COMPLETE

# enable cmdline correction
#setopt CORRECT
#setopt CORRECT_ALL

# disable beep
setopt nobeep

# enable cmdline completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# up/down searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# frequently used
# bindkey "^R" history-incremental-search-backward # commented out to not override fzf ^R
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line
bindkey "[C" forward-word
bindkey "[D" backward-word

# in-place delete
bindkey '^[[3~'  delete-char

# don't remove space after tab completion for these characters
# https://unix.stackexchange.com/questions/174630/keep-the-space-after-completion-for-some-characters-in-zsh
ZLE_SPACE_SUFFIX_CHARS=$'|&'

