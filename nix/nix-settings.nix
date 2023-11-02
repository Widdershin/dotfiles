{ ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowAliases = true;

  # Enable flake and nix commmand support, and x86 platform support
  nix.extraOptions = ''
    experimental-features = flakes nix-command
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.settings.trusted-users = ["nick" "root"];
}
