source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle tmux
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
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
export PATH="$PATH:/usr/lib/postgresql/9.1/bin"
export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Powerline cfg
export POWERLINE_ROOT=$HOME/Library/Python/2.7/lib/python/site-packages/powerline

alias nz="PS_MARKET=nz"
alias au="PS_MARKET=au"
alias c="rails c"
alias s="rails s"
alias e="vim"
alias be="bundle exec"
alias rails='be rails'
alias rake='be rake'
alias spec='be spring rspec'
alias cuke='be spring cucumber'
alias nzb="nz be"
alias aub="au be"

alias ev="vim ~/.zshrc"
alias sv="source ~/.zshrc"

alias psactive='[ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host akl.secure.powershop.co.nz|cut -d" " -f4` ] && echo akl || [ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host wlg.secure.powershop.co.nz|cut -d" " -f4` ] && echo wlg'
alias psinactive='[ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host akl.secure.powershop.co.nz|cut -d" " -f4` ] && echo wlg || [ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host wlg.secure.powershop.co.nz|cut -d" " -f4` ] && echo akl'

export EDITOR='vim'
stty -ixon

if [[ "$TERM" != "screen-256color" ]] &&
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
