{ pkgs, ... }: {
  programs.bash.enableCompletion = true;

  programs.zsh.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;
  programs.zsh.interactiveShellInit = ''
    # pure-prompt
    . ${pkgs.pure-prompt}/share/zsh/site-functions/async
    . ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
  '';
  programs.zsh.promptInit = "";

  programs.zsh.variables.cfg = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  programs.zsh.variables.darwin = "$HOME/.nix-defexpr/darwin";
  programs.zsh.variables.nixpkgs = "$HOME/.nix-defexpr/nixpkgs";

  environment.variables.LANG = "en_US.UTF-8";
}
