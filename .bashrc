# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"
eval "$(rbenv init -)"

# Unix
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias l='ls'
alias ll='ls -al'
alias lh='ls -Alh'
alias G='| grep'
alias M='| less'
alias L='| wc -l'
alias ONE="| awk '{ print \$1}'"
alias e="$EDITOR"
alias v="$VISUAL"
alias zr="source ~/.zshrc && rbenv rehash"
alias c="clear"
alias ae="vi ~/.aliases"

# git
alias gci="git pull --rebase && rake && git push"
alias gps="git push"
alias gs="git status"
alias gps="git push"
alias gpl="git fetch && git pull"
alias gst="git stash"
alias gf="git fetch"
alias gb="git branch"
alias gco="git checkout"

# Bundler
alias b="bundle"

# Tests and Specs
alias t="ruby -I test"
alias cuc="bundle exec cucumber"

# Rubygems
alias gi="gem install"
alias giv="gem install -v"

# Rails
alias migrate="rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare"
alias m="migrate"
alias rk="rake"
alias s="rspec"
alias z="zeus"

# Applications
alias sub="subl"
