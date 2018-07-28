
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


##################
# Command Prompt #
##################
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch) \$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

