source ~/antigen/antigen.zsh

antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply

# Nicer diff highlighting
# ln -sf "$(brew --prefix)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

# command correction
setopt correct

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:/usr/lib/postgresql/9.1/bin";
export PROJECT_HOME=$HOME/Projects

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export GOPATH=$HOME
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$HOME/.cabal/bin"

# History
HISTSIZE=5000000        # How many lines of history to keep in memory
HISTFILE=~/.zsh_history # Where to save history to disk
SAVEHIST=5000000        # Number of history entries to save to disk

setopt appendhistory    # Append history to the history file (no overwriting)
setopt sharehistory     # Share history across terminals
setopt incappendhistory # Immediately append to the history file, not just when a term is killed

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

function using() { nix-shell -p $1 --run zsh }
function run() { tmux split-window -l 10 -bc "#{pane_current_path}" "$*; read"; tmux select-pane -D }

function db() {
  git_dir=$(git rev-parse --show-toplevel)

  PGHOST=localhost \
    PGUSER=postgres \
    PGPASSWORD=bananapancakes \
    PGPORT=$(cat "$git_dir"/.pgport) \
    "$@"
}

function tcpf () { lsof -i TCP:$1 }

function keep() {
  local res=$(which $*)
  echo $res >> ~/dotfiles/functions.sh
}

source ~/dotfiles/functions.sh

alias vis="tmux split-window -hc "#{pane_current_path}" nvim"

alias production="AWS_DEFAULT_PROFILE=prod"
alias operator="AWS_DEFAULT_PROFILE=operator"
alias c="rails c"
alias e="nvim"
alias vi="nvim"
alias be="bundle exec"
alias bi="bundle install"
alias rails='be rails'
alias agst="watch -n 1 --color git status -sb"
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

export EDITOR='nvim'
stty -ixon

export NIX_IGNORE_SYMLINK_STORE=1
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

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

export PGDATA='/usr/local/var/postgres'

dosh ()
{
  container=$(docker ps | grep -v CONTAINER | fzf --preview 'docker exec $(echo {} | cut -d" " -f1) ps aux' | cut -d' ' -f1)
  docker exec -it $container bash
}

dosha ()
{
  container=$(docker ps | grep -v CONTAINER | fzf --preview 'docker attach $(echo {} | cut -d" " -f1)' | cut -d' ' -f1)
  docker attach $container
}

eval "$(rbenv init -)"

source /Users/nick/Library/Preferences/org.dystroy.broot/launcher/bash/br

# added by travis gem
[ -f /Users/nick/.travis/travis.sh ] && source /Users/nick/.travis/travis.sh
