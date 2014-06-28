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


[[ $TERM != "screen" ]] && exec tmux attach || exec tmux new