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
export GOPATH=$HOME/Github/go
alias cdgo="cd ${GOPATH}"


##########
# Gopass #
##########
export _gopass_custom_config=$HOME/dotfiles/myfuncs/gopass/gopass_config


#######
# GPG #
#######
export GPG_TTY=$(tty)
alias glock='gpgconf --kill gpg-agent'


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


##################
# Source myfuncs #
##################
. ~/dotfiles/myfuncs/cmdline_funcs
. ~/dotfiles/myfuncs/git/git_funcs
. ~/dotfiles/myfuncs/gopass/gopass_funcs
. ~/dotfiles/myfuncs/gpg_funcs
. ~/dotfiles/myfuncs/metabase_funcs
. ~/dotfiles/myfuncs/python/newvenv
. ~/dotfiles/myfuncs/python/pycheck
. ~/dotfiles/myfuncs/sdrive_funcs

if [[ -d ~/dotfiles/work ]]; then
	. ~/dotfiles/work/work
fi


##################
# Command Prompt #
##################
setopt PROMPT_SUBST
PROMPT='%(?^%F{cyan}[%n@%m] [%2~]$(git_branch)%f^%F{red}[%n@%m] [%2~]$(git_branch)%f) $ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


########
# PATH #
########
export PATH=$HOME/bin:$PATH


############
# ZSH OPTS #
############

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# share history across multiple zsh sessions
#setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# write history with timestamp
#setopt EXTENDED_HISTORY
# verify previous command (!!)
setopt HIST_VERIFY

# list but don't replace globs
setopt GLOB_COMPLETE

# enable cmdline correction
#setopt CORRECT
#setopt CORRECT_ALL

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
bindkey "^R" history-incremental-search-backward
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

# in-place delete
bindkey '^[[3~'  delete-char

