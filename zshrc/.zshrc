###########
# Aliases #
###########
alias ls='ls -lhFG'
alias lsa='ls -lahFG'
alias gits='git status'
alias glock='gpgconf --kill gpg-agent'


#######
# Git #
#######
export EDITOR='vim'

# Git branch in prompt
git_branch() {
	branch="$(git branch 2>/dev/null | grep \* | awk -F '\\* ' '{$0=$2}1')"
	if [ ! -z "$branch" ]; then	
		printf "[%s]" "$branch"
	fi
}


######
# Go #
######
export GOPATH=$HOME/Github/go


#######
# GPG #
#######
export GPG_TTY=$(tty)


##########
# Python #
##########
export PIP_REQUIRE_VIRTUALENV=true


##################
# Command Prompt #
##################
setopt PROMPT_SUBST
PROMPT='%(?^%F{cyan}[%n@%m] [%2~] $(git_branch)%f^%F{red}[%n@%m] [%2~] $(git_branch)%f) $ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


##################
# Source myfuncs #
##################
. ~/dotfiles/myfuncs/cmdline_funcs
. ~/dotfiles/myfuncs/git/git_funcs
. ~/dotfiles/myfuncs/gopass_funcs
. ~/dotfiles/myfuncs/gpg_funcs
. ~/dotfiles/myfuncs/python_venv/newvenv
. ~/dotfiles/myfuncs/sdrive_funcs


############
# ZSH OPTS #
############

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# write history with timestamp
#setopt EXTENDED_HISTORY
# verify previous command (!!)
setopt HIST_VERIFY

# list but don't replace globs
setopt GLOB_COMPLETE

# enable cmdline correction
setopt CORRECT
setopt CORRECT_ALL

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

