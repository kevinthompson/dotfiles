eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -d "$HOME/Code/pco" ]; then
  eval "$($HOME/Code/pco/bin/pco init -)" 
fi

if [ -d "$HOME/pco-box" ]; then
  source $HOME/pco-box/env.sh
fi

# Added by `rbenv init` on Thu Dec  5 07:35:33 PST 2024
eval "$(rbenv init - --no-rehash zsh)"
