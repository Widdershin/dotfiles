{ pkgs, ... }: {
  programs.bash.enableCompletion = true;

  programs.zsh.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;
  programs.zsh.promptInit = "autoload -U promptinit && promptinit && prompt pure";

  programs.zsh.variables.cfg = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  programs.zsh.variables.darwin = "$HOME/.nix-defexpr/darwin";
  programs.zsh.variables.nixpkgs = "$HOME/.nix-defexpr/nixpkgs";

  environment.variables.LANG = "en_US.UTF-8";
}
