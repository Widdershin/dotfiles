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

  fonts.fontDir.enable = true;
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
    #Amphetamine = 937984704;
  };

  homebrew.extraConfig = ''
    brew "postgresql@12", restart_service: true, link: true
    brew "redis", restart_service: true, link: true
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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
    ];

  # Auto upgrade nix package and the daemon service.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  services.nix-daemon.enable = true;
  services.tailscale.enable = true;
  services.tailscale.package = pkgs.tailscale;

  nix.extraOptions = ''
    experimental-features = flakes nix-command
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  nix.settings.trusted-users = ["nick" "root"];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.vim.package = pkgs.neovim.override {
      configure = {
        packages.darwin.start = neovimPackages;
        customRC = plugins;
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
