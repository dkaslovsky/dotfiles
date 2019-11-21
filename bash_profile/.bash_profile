
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
# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Git completion
. ~/dotfiles/myfuncs/git/.git-completion.bash


######
# Go #
######
export GOPATH=$HOME/Github/go


#######
# GPG #
#######
export GPG_TTY=$(tty)


##########
# Gopass #
##########
export GP=~/.password-store/
source /dev/stdin <<<"$(gopass completion bash)"


##########
# Python #
##########
export PIP_REQUIRE_VIRTUALENV=true

# from python3.7 install, appears to not be needed
#PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
#export PATH


##################
# Command Prompt #
##################
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch) \$ "
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
