{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [ # terminal
      zsh
      kitty
      pure-prompt

      # neovim and friends
      config.programs.vim.package
      ctags
      fzf

      # git and co
      git
      tig

      # searching
      silver-searcher
      ripgrep # used by telescope.nvim

      # filesystem management
      bat
      jq
      tree

      # watchers
      watch

      # webdev
      httpie
      wget
      wrk
      geckodriver
      yarn

      # system info
      htop
      ncdu
      pstree

      # networking utils
      socat

      # programming languages
      nodejs-18_x
      python3

      # linters
      shellcheck

      # devops
      aws-vault
      awscli
      heroku
      terraform

      # direnv and friends
      direnv
      nix-direnv-flakes

      # nix utils
      nix-prefetch-github
      cachix

      # database clients
      sqlite

      # common dev libs
      libjpeg
    ];
}
