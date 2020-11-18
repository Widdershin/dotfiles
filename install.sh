mkdir -p ~/.config/
mkdir -p ~/.config/nixpkgs/overlays/

ln -s $PWD/config/nvim $HOME/.config/nvim
ln -s $PWD/eslintrc $HOME/.eslintrc
ln -s $PWD/nick.nix $HOME/.config/nixpkgs/overlays/nick.nix
ln -s $PWD/tmux.conf $HOME/.tmux.conf
ln -s $PWD/tmux.theme $HOME/.tmux.theme
ln -s $PWD/zshenv $HOME/.zshenv
ln -s $PWD/zshrc $HOME/.zshrc
