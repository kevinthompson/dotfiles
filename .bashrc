# Environment
if [ -f ~/.environment ]; then
  . ~/.environment
fi

# Aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Prompt
if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh
fi
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

# VI Mode
set -o vi
