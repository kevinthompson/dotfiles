if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
eval $(/usr/libexec/path_helper -s)

export PATH="$HOME/.cargo/bin:$PATH"
export RBENV_ROOT=$HOME/.rbenv
export MYSQL_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_SLAVE_PORT_3306_TCP_PORT=3307
export PATH=/Users/kevinthompson/pco-box/bin:/usr/local/bin:$PATH
eval "$(rbenv init -)"
export MYSQL_READER_PORT_3306_TCP_ADDR=127.0.0.1
export MYSQL_READER_PORT_3306_TCP_PORT=3307
