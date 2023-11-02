{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [ config.programs.vim.package 
      silver-searcher
      bat
      ctags
      fzf
      git
      httpie
      jq
      pstree
      tig
      watch
      wget
      zsh
      ncdu
      socat
      reattach-to-user-namespace
      wrk
      htop
      nodejs-18_x
      aws-vault
      python3
      direnv
      yarn
      shellcheck
      # chromedriver
      geckodriver
      awscli
      heroku
      nix-prefetch-github
      #docker
      tabnine
      tmux
      kitty
      sqlite
      libjpeg
      nix-direnv-flakes
      tailscale
      terraform

      # used by telescope
      ripgrep

      cachix
      pure-prompt
    ];
}
