{ config, pkgs, ... }:

let
  loadPlugin = p: ''
    set rtp^=${p.outPath}
    set rtp+=${p.outPath}/after
  '';

  plugins = ''
    " Workaround for broken handling of packpath by vim8/neovim for ftplugins
    filetype off | syn off
    ${pkgs.lib.concatStrings (map loadPlugin neovimPackages)}
    filetype indent plugin on | syn on
    so ~/dotfiles/config/nvim/init.vim
  '';

  neovimPackages = with pkgs.vimPlugins; [
    vim-sensible
    vim-surround
    vim-endwise
    vim-abolish
    vim-repeat
    gundo-vim
    vim-plug
    nerdtree
    vim-css-color
    vim-better-whitespace
    vim-peekaboo
    vim-fugitive
    vim-tmux-navigator
    tslime-vim
    vim-tmux-focus-events
    vimproc-vim
    Improved-AnsiEsc
    telescope-fzf-native-nvim
  ];
in
{
  programs.vim.package = pkgs.neovim.override {
    withRuby = false;

    configure = {
      packages.darwin.start = neovimPackages;
      customRC = plugins;
    };
  };
}
