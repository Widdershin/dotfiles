source ~/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle tmux
#antigen bundle virtualenv
antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-completions src

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://gist.github.com/Widdershin/a080ec7a6af0f943f40f agnoster

antigen bundle https://gist.github.com/Widdershin/406b3a7cd8707741e1aa


# Tell antigen that you're done.
antigen apply


# command correction
setopt correct

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
export PATH="$PATH:/usr/lib/postgresql/9.1/bin"
#export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Powerline cfg
export POWERLINE_ROOT=$HOME/Library/Python/2.7/lib/python/site-packages/powerline
export PYTHONPATH=/lib/python2.7/site-packages/


alias nz="export PS_MARKET=nz && sed -i bak 's/au/nz/' .powenv && rm .powenvbak && powder restart"
alias au="export PS_MARKET=au && sed -i bak 's/nz/au/' .powenv && rm .powenvbak && powder restart"
alias c="rails c"
alias s="rails s"
alias e="nvim"
alias vi="nvim"
alias be="bundle exec"
alias bi="bundle install"
alias rails='be rails'
alias rake='be rake'
alias spec='be spring rspec'
alias cuke='be spring cucumber'
alias nzb="nz be"
alias aub="au be"
alias agst="watch -n 1 --color git status -sb"
alias g-="gco -"
alias migrate="PS_MARKET=nz rake db:migrate && PS_MARKET=au rake db:migrate"

alias ev="vim ~/.zshrc"
alias sv="source ~/.zshrc"

alias nzpsactive='([ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host akl.secure.powershop.co.nz|cut -d" " -f4` ] && echo akl) || ([ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host wlg.secure.powershop.co.nz|cut -d" " -f4` ] && echo wlg)'
alias nzpsinactive='([ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host akl.secure.powershop.co.nz|cut -d" " -f4` ] && echo wlg) || ([ `host secure.powershop.co.nz|cut -d" " -f4` "==" `host wlg.secure.powershop.co.nz|cut -d" " -f4` ] && echo akl)'

alias aupsactive='([ `host secure.powershop.com.au|cut -d" " -f4` "==" `host akl.secure.powershop.com.au|cut -d" " -f4` ] && echo akl) || ([ `host secure.powershop.com.au|cut -d" " -f4` "==" `host wlg.secure.powershop.com.au|cut -d" " -f4` ] && echo wlg)'
alias aupsinactive='([ `host secure.powershop.com.au|cut -d" " -f4` "==" `host akl.secure.powershop.com.au|cut -d" " -f4` ] && echo wlg) || ([ `host secure.powershop.com.au|cut -d" " -f4` "==" `host wlg.secure.powershop.com.au|cut -d" " -f4` ] && echo akl)'

alias beetil='open "https://desk.gotoassist.com/goto?q=$(git symbolic-ref --short HEAD | cut -c 2-)"'

sshs() {
  if [[ $1 == *"prod"* ]]
  then
    PS_ENV='_prod'
  else
    PS_ENV=''
  fi

  ssh $@ "cat > /tmp/.bashrc_temp_$USER" < ~/.bashrc_remote$PS_ENV 2> /dev/null
  ssh -t $@ "ACTIVE_PROD='$ACTIVE_PROD' bash --rcfile /tmp/.bashrc_temp_$USER ; rm /tmp/.bashrc_temp_$USER"
}

alias ssh=sshs

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
