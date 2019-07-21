self: super:

{
  userPackages              = super.userPackages or {} // {
    self.config.allowUnfree = true;
    self.config.allowUnsupportedSystem = true;

    # core
    cacert                  = self.cacert;
    nix                     = self.nix;

    # terminal
    ag                      = self.ag;
    bat                     = self.bat;
    ctags                   = self.ctags;
    fzf                     = self.fzf;
    git                     = self.git;
    httpie                  = self.httpie;
    jq                      = self.jq;
    neovim                  = self.neovim;
    pstree                  = self.pstree;
    tig                     = self.tig;
    tmux                    = self.tmux;
    tmux-fzf-url            = self.tmuxPlugins.fzf-tmux-url;
    tree                    = self.tree;
    watch                   = self.watch;
    wget                    = self.wget;
    zsh                     = self.zsh;
    ncdu                    = self.ncdu;
    youtube-dl              = self.youtube-dl;
    ffmpeg                  = self.ffmpeg;
    gettext                 = self.gettext;
    rlwrap                  = self.rlwrap;
    direnv                  = self.direnv;

    # databases
    postgresql              = self.postgresql;

    # docker
    docker                  = self.docker;
    docker_machine          = self.docker-machine;
    docker_compose          = self.docker_compose;

    # programming languages
    node                    = self.nodejs-10_x;
    shellcheck              = self.shellcheck;

    # web development
    chromedriver            = self.chromedriver;
    geckodriver             = self.geckodriver;

    # devops
    terraform               = self.terraform;
    aws                     = self.awscli;
    python3                 = self.python3;
    pip                     = self.python37Packages.pip;
    nixops                  = self.nixopsUnstable;
    heroku                  = self.heroku;

    # nix tooling
    pypi2nix                = self.pypi2nix;
    bundix                  = self.bundix;
    prefetch-github         = self.nix-prefetch-github;

    # haskell tools
    hoogle                  = self.haskellPackages.hoogle;

    nix-rebuild             = super.writeScriptBin "nix-rebuild" ''
      #!${super.stdenv.shell}
      if ! command -v nix-env &>/dev/null; then
          echo "warning: nix-env was not found in PATH, add nix to userPackages" >&2
          PATH=${self.nix}/bin:$PATH
      fi
      exec nix-env -f '<nixpkgs>' -r -iA userPackages "$@"
    '';

  };
}
