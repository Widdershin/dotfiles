self: super:

let
  update-prefetch-src = self.fetchFromGitHub {
    owner = "justinwoo";
    repo = "update-prefetch";
    rev = "80b8f6eaa0108a1666d0e8bd8dc81ba810ce5f77";
    sha256 = "04sgd37rh5zvx01c3cqf1p2c2alaqzd4r160wspnw6y1avwi1apz";
  };
  latestPkgs =
    import (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2019-10-10";
      # Commit hash for nixos-unstable as of 2018-01-06
      url = https://github.com/nixos/nixpkgs/archive/1f5fa9a8298ec7411431da981b4f1a79e10f2a8e.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1696ymp66ndbb0b49sbqi2g3y49k041hv6gd0i6kgfrvi1kqkidm";
    }) {};
in
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
    neovim                  = latestPkgs.neovim;
    pstree                  = self.pstree;
    tig                     = self.tig;
    tmux                    = self.tmux;
    tree                    = self.tree;
    watch                   = self.watch;
    wget                    = self.wget;
    zsh                     = self.zsh;
    ncdu                    = self.ncdu;
    reattach-to-user-namespace = self.reattach-to-user-namespace;
siege = self.siege;
    mosh = self.mosh;
htop = self.htop;
    # programming languages
    node                    = self.nodejs-10_x;
    shellcheck              = self.shellcheck;

    # web development
    chromedriver            = self.chromedriver;
    geckodriver             = self.geckodriver;

    # devops
    terraform               = self.terraform;
    aws                     = self.awscli;
    python                 = self.python27;
    nixops                  = self.nixopsUnstable;
    heroku                  = self.heroku;

    # nix tooling
    prefetch-github         = self.nix-prefetch-github;
    update-prefetch = import "${update-prefetch-src}/default.nix" {};

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
