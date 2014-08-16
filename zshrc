source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle bundler
antigen bundle tmux
antigen bundle pyenv
antigen bundle virtualenv

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://gist.github.com/Widdershin/a080ec7a6af0f943f40f agnoster

antigen bundle https://gist.github.com/Widdershin/406b3a7cd8707741e1aa

# Tell antigen that you're done.
antigen apply

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PGDATA="/var/lib/pgsql/data"
export PATH="$PATH:/usr/lib/postgresql/9.1/bin"

export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

if [[ "$TERM" != "screen" ]] &&
    ; then
    # Attempt to discover a detached session and attach
    # it, else create a new session

    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null; then
        tmux -2 attach-session -t $WHOAMI
    else
        tmux -2 new-session -s $WHOAMI
    fi
else

    # One might want to do other things in this case,
    # here I print my motd, but only on servers where
    # one exists

    # If inside tmux session then print MOTD
    MOTD=/etc/motd.tcl
    if [ -f $MOTD ]; then
        $MOTD
    fi
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
