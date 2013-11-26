# Enable Completion
autoload -U compinit
compinit

# Directory Navigation
setopt auto_cd
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Define Editor
export VISUAL=vim
export EDITOR=$VISUAL

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

# Expand Functions In The Prompt
setopt prompt_subst

# Prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# History
HISTSIZE=5000               # How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=5000               # Number of history entries to save to disk
HISTDUP=erase               # Erase duplicates in the history file
setopt appendhistory        # Append history to the history file (no overwriting)
setopt sharehistory         # Share history across terminals
setopt incappendhistory     # Immediately append to the history file, not just when a term is killed
setopt histignoredups

# Enable Extended Globbing
setopt EXTENDED_GLOB

# Change iTerm2 Profile
profile() { echo -e "\033]50;SetProfile=$1\a" }

# Path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
