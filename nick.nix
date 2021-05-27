self: super:

let
  pinned =
    import (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2019-10-10";
      # Commit hash for nixos-unstable as of 2018-01-06
      url = https://github.com/nixos/nixpkgs/archive/cfed29bfcb28259376713005d176a6f82951014a.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "034m892hxygminkj326y7l3bp4xhx0v154jcmla7wdfqd23dk5xm";
    }) {};
  pinned2021 =
    import (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2021-02-10";
      # Commit hash for nixos-unstable as of 2018-01-06
      url = https://github.com/nixos/nixpkgs/archive/ead24f04b06a5d5cb224b1cb5be6ae59c58c6915.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "06ad1688wg8s6pfw7z5icl4mmynh9ldi6j0b5c08h32br8fpawjy";
    }) {};

  latest = self;
  neuron =
    (let neuronRev = "99154121591ad419569fd6d506e84cf52641b057";
         neuronSrc = builtins.fetchTarball "https://github.com/srid/neuron/archive/${neuronRev}.tar.gz";
         in import neuronSrc {});
in
{
  userPackages              = super.userPackages or {} // {
    self.config.allowUnfree            = true;
    self.config.allowUnsupportedSystem = true;

    # core
    cacert                     = pinned.cacert;
    nix                        = pinned.nix;

    # terminal
    ag                         = pinned.ag;
    bat                        = pinned.bat;
    ctags                      = pinned.ctags;
    fzf                        = pinned.fzf;
    git                        = pinned.git;
    httpie                     = pinned.httpie;
    jq                         = pinned.jq;
    pstree                     = pinned.pstree;
    tig                        = pinned.tig;
    tmux                       = pinned.tmux;
    tree                       = pinned.tree;
    watch                      = pinned.watch;
    wget                       = pinned.wget;
    zsh                        = pinned.zsh;
    ncdu                       = pinned.ncdu;
    socat                      = pinned.socat;
    reattach-to-user-namespace = pinned.reattach-to-user-namespace;
    siege                      = pinned.siege;
    mosh                       = pinned.mosh;
    htop                       = pinned.htop;

    # programming languages
    node                       = pinned.nodejs-12_x;
    yarn                       = pinned.yarn;
    shellcheck                 = pinned.shellcheck;
    fsharp                     = pinned.fsharp;

    # web development
    chromedriver               = pinned.chromedriver;
    geckodriver                = pinned.geckodriver;

    # devops
    terraform                  = pinned2021.terraform_0_14;
    aws                        = pinned.awscli;
    python                     = pinned2021.python37.withPackages (p: with p; [
      pinned2021.python37Packages.pynvim
    ]);
    nixops                     = pinned.nixopsUnstable;
    heroku                     = pinned.heroku;

    # nix tooling
    prefetch-github            = pinned.nix-prefetch-github;
    neuron                     = neuron;

    nix-rebuild = super.writeScriptBin "nix-rebuild" ''
      #!${super.stdenv.shell}
      if ! command -v nix-env &>/dev/null; then
          echo "warning: nix-env was not found in PATH, add nix to userPackages" >&2
          PATH=${self.nix}/bin:$PATH
      fi
      exec nix-env -f '<nixpkgs>' -r -iA userPackages "$@"
    '';
  };
}
