# Functions
fpath=(/Users/kevinthompson/code/zsh-completions/src $fpath)

# Enable Completion
autoload -U compinit
compinit

# Path
export GOPATH="/Users/kevinthompson/code/go"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"  # Standard Path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"        # Homebrew
export PATH="/usr/local/share/npm/bin:$PATH"              # Node
export PATH="$GOPATH/bin:$PATH"                           # Go
export PATH="$HOME/.bin:$PATH"                            # Custom Binaries

# Define Editor
export VISUAL=vim
export EDITOR=$VISUAL

# Commands
eval "$(rbenv init - zsh)"
eval "$(gh alias -s)"

# Enable Colors
autoload -U colors
colors
export CLICOLOR=1

# Directory Navigation
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt EXTENDED_GLOB
setopt auto_cd
setopt cdablevars
setopt prompt_subst

# History
HISTSIZE=5000               # How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=5000               # Number of history entries to save to disk
HISTDUP=erase               # Erase duplicates in the history file
setopt appendhistory        # Append history to the history file (no overwriting)
setopt sharehistory         # Share history across terminals
setopt incappendhistory     # Immediately append to the history file, not just when a term is killed
setopt histignoredups

# VI Mode in Terminal
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# Incremental Search
bindkey "^R" history-incremental-search-backward

# Readline Keys
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# Keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A"

# Prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# Git Prompt
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# Prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

# Change iTerm2 Profile
profile() { echo -e "\033]50;SetProfile=$1\a" }

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local Config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
