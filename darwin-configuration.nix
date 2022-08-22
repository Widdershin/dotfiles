{ config, pkgs, ... }:

let
  pkgsM1 = import <unstable> { localSystem = "aarch64-darwin"; };
  pkgsX86 = import <unstable> { localSystem = "x86_64-darwin"; };

  loadPlugin = p: ''
    set rtp^=${p.rtp}
    set rtp+=${p.rtp}/after
  '';

  plugins = ''
    " Workaround for broken handling of packpath by vim8/neovim for ftplugins
    filetype off | syn off
    ${pkgs.lib.concatStrings (map loadPlugin neovimPackages)}
    filetype indent plugin on | syn on
  '';

  neovimPackages = with pkgs.vimPlugins; [
    vim-sensible
    vim-surround
    vim-endwise
    vim-abolish
    vim-repeat
    polyglot
    vim-easy-align
    NrrwRgn
    gundo-vim
    neuron-vim
    vim-plug
    fzfWrapper
    fzf-vim
    nerdtree
    vim-airline
    vim-css-color
    vim-better-whitespace
    golden-ratio
    vim-dispatch
    vim-peekaboo
    jellybeans-vim
    vim-fugitive
    vim-gitgutter
    vim-tmux-navigator
    tslime-vim
    vim-tmux-focus-events
    vimproc-vim
    deoplete-nvim
    Improved-AnsiEsc
    #	vitality-vim
  ];
in
{
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = true;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  fonts.enableFontDir = true;
  fonts.fonts = [ pkgs.hack-font ];

  homebrew.enable = true;
  homebrew.brewPrefix = "/opt/homebrew/bin";
  homebrew.brews = [
    "pure"
    "tako8ki/tap/frum"
  ];

  homebrew.casks = [
  ];

  homebrew.masApps = {
    Amphetamine = 937984704;
  };

  homebrew.extraConfig = ''
    tap "mongodb/brew"
    brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]
    brew "memcached", restart_service: true, link: true
    brew "mongodb/brew/mongodb-community", restart_service: true, link: true
    tap "elastic/tap"
    brew "elastic/tap/elasticsearch-full", restart_service: true, link: true
    brew "postgresql@12", restart_service: true, link: true
    brew "redis", restart_service: true, link: true
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;
    [ config.programs.vim.package
      ag
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
      siege
      htop
      pkgsX86.nodejs-14_x
      ruby
      direnv
      yarn
      shellcheck
      # chromedriver
      geckodriver
      terraform_0_14
      awscli
      heroku
      nix-prefetch-github
      docker
      tabnine
      tmux
    ];

  # Auto upgrade nix package and the daemon service.
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-commmand flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  nix.trustedUsers = ["nick" "root"];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.vim.package = pkgs.neovim.override {
      configure = {
        packages.darwin.start = neovimPackages
          ++ (with pkgs.vimPlugins; [ ale ]);
        customRC = plugins + builtins.readFile ~/dotfiles/config/nvim/init.vim;
    };
  };

  programs.bash.enableCompletion = true;

  programs.zsh.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;
  programs.zsh.promptInit = "";

  programs.zsh.variables.cfg = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  programs.zsh.variables.darwin = "$HOME/.nix-defexpr/darwin";
  programs.zsh.variables.nixpkgs = "$HOME/.nix-defexpr/nixpkgs";

  environment.loginShell = "${pkgs.zsh}/bin/zsh -l";
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  environment.variables.LANG = "en_US.UTF-8";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
