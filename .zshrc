# Enable Completion
fpath=(~/.zsh/completion $fpath)
rm -f ~/.zcompdump
autoload -U compinit
compinit

# Environment
[[ -f ~/.environment ]] && source ~/.environment

# Enable Colors
autoload -U colors
colors
export CLICOLOR=1
export VISUAL="nvim"

# Directory Navigation
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt auto_cd
setopt cdablevars
setopt prompt_subst
unsetopt nomatch

# Completion
setopt EXTENDED_GLOB
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

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

# PATH
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/Users/kevinthompson/.cargo/bin

# Prompt
export PS1='%{$fg[blue]%}%1~%{$reset_color%}$(git_prompt_info) %{$fg[blue]%}$ %{$reset_color%}'

# Change iTerm2 Profile
profile() { echo -e "\033]50;SetProfile=$1\a" }

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'

# Bindings
[[ -f ~/.zsh/bindings ]] && source ~/.zsh/bindings

# Aliases
[[ -f ~/.zsh/aliases ]] && source ~/.zsh/aliases

# Local Config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
