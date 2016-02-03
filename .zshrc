# Functions
fpath=(/Users/kevinthompson/code/zsh-completions/src $fpath)

# Enable Completion
autoload -U compinit
compinit

# Environment
[[ -f ~/.environment ]] && source ~/.environment

# Enable Colors
autoload -U colors
colors
export CLICOLOR=1
export VISUAL="vim"

# Directory Navigation
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt EXTENDED_GLOB
setopt auto_cd
setopt cdablevars
setopt prompt_subst
unsetopt nomatch

# History
HISTSIZE=5000               # How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=5000               # Number of history entries to save to disk
HISTDUP=erase               # Erase duplicates in the history file
setopt appendhistory        # Append history to the history file (no overwriting)
setopt sharehistory         # Share history across terminals
setopt incappendhistory     # Immediately append to the history file, not just when a term is killed
setopt histignoredups

# Git Prompt
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " (${ref#refs/heads/})"
  fi
}

# Prompt
export PS1='${SSH_CONNECTION+"%{$fg[green]%}%n@%m:"}%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info) %{$fg[blue]%}$ %{$reset_color%}'

# Change iTerm2 Profile
profile() { echo -e "\033]50;SetProfile=$1\a" }

# Bindings
[[ -f ~/.zsh/bindings ]] && source ~/.zsh/bindings

# Aliases
[[ -f ~/.zsh/aliases ]] && source ~/.zsh/aliases

# Local Config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

export NVM_DIR="/Users/kevinthompson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
