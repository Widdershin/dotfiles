source ~/antigen/antigen.zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-completions src

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://gist.github.com/Widdershin/a080ec7a6af0f943f40f agnoster

# Tell antigen that you're done.
antigen apply

# Nicer diff highlighting
# ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# command correction
setopt correct

export PATH="/usr/local/bin:$PATH"
export PATH="/Users/nickj/.local/bin:$PATH"

eval "$(rbenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"

export PATH="$PATH:/usr/lib/postgresql/9.1/bin"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export GOPATH=$HOME
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:/Users/nickj/.cabal/bin"

# History
HISTSIZE=5000000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000000 #Number of history entries to save to disk

setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt incappendhistory #Immediately append to the history file, not just when a term is killed

# git aliases
alias gc="git commit -v"
alias gc!='git commit -v --amend'
alias ga="git add"
alias gst="git status"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias ggpush='git push origin $(current_branch)'
alias gl='git pull'
alias ggpull='git pull origin $(current_branch)'

compdef ggpush=git
compdef ggpull=git
compdef _git gc!=git-commit


function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function clone {
  repo_name=$(echo $* | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)
  dir=~/Projects/$repo_name

  tmux switch-client -t "$(TMUX= tmux -S "${TMUX%,*,*}" new-session -dP -s $repo_name "git clone $* $dir; cd $dir; zsh")"
}

function db() {
  git_dir=$(git rev-parse --show-toplevel)

  PGHOST=localhost \
    PGUSER=postgres \
    PGPASSWORD=bananapancakes \
    PGPORT=$(cat "$git_dir"/.pgport) \
    "$@"
}

alias vis="tmux split-window -hc "#{pane_current_path}" reattach-to-user-namespace nvim"

alias production="AWS_DEFAULT_PROFILE=prod"
alias operator="AWS_DEFAULT_PROFILE=operator"
alias c="rails c"
alias e="nvim"
alias nvim="reattach-to-user-namespace nvim"
alias vi="reattach-to-user-namespace nvim"
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
alias gdc="git diff --cached"
alias pingle="gtimeout 3 ping google.com"
alias ip="ifconfig en0 | grep 'inet\W' | cut -d' ' -f2"
alias s="~/smart-switch.rb"
alias gcof="git branch | cut -c3-50 | fzf | xargs git checkout"
gitlog ()
{
  git log master.. --format="%Cgreen[$(git symbolic-ref --short HEAD) %C(bold blue)%h]%C(green)%ar %C(bold blue)%an %Creset%s" --no-merges --reverse
}

commitlog ()
{
  git log master.. --format="%Cgreen[$(git symbolic-ref --short HEAD) %C(bold blue)%h] %Creset%s" --no-merges --reverse
}

alias mkrb="~/utils/mkrb/mkrb.py"
alias mvrb="~/utils/mvrb/mvrb.py"

alias ev="vi ~/.zshrc"
alias sv="source ~/.zshrc"

alias whoisthatsnail="say 'Meow' && echo His name is Gary and he\'s very sensitive."

[ -f $HOME/Projects/spectacle-workflow-tools/wt ] && source $HOME/Projects/spectacle-workflow-tools/wt

export EDITOR='nvim'
stty -ixon

if [ -e /Users/nickj/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/nickj/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

if [[ "$PWD" == "/Users/nickj/Projects/powershop" ]]; then
  source .powenv
fi

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

export PATH="/usr/local/sbin:$PATH"

bindkey -e
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -l -g ""'

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

