
#######
# Git #
#######
# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


######
# Go #
######
export GOPATH=$HOME/Github/go


#######
# GPG #
#######
export GPG_TTY=$(tty)
alias glock='gpgconf --kill gpg-agent'
source ~/.gpg_funcs


##########
# GOPASS #
##########
source /dev/stdin <<<"$(gopass completion bash)"
export GP=~/.password-store/

# given absolute path to gopass secret, get and open the url in Chrome, copy password to clipboard
gpopen() {
	secret_path=$(echo $1 | sed "s|$GP||" | sed "s/.gpg//")
	url=$(gopass $secret_path | head -n 2 | tail -n 1 | sed "s/url: //")
	open -na "Google Chrome" --args --new-window $url
	gopass -c $secret_path
}

# show all but the first line of gopass secret
gpshow() {
	tail -n +2 $1
	echo ""
}


##########
# Python #
##########
export PIP_REQUIRE_VIRTUALENV=true


##################
# Command Prompt #
##################
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch) \$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


################
# Sdrive rsync #
################
source ~/.sdrive_funcs


###########
# aliases #
###########
alias ls='ls -lhFG'
alias gits='git status'

