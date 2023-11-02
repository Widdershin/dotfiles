{ config, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.fonts = [ pkgs.hack-font ];

  services.tailscale.enable = true;
  services.tailscale.package = pkgs.tailscale;

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
