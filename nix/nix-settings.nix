{ inputs, pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixVersions.nix_2_20;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowAliases = true;

  # Enable flake and nix commmand support, and x86 platform support
  nix.extraOptions = ''
    experimental-features = flakes nix-command repl-flake configurable-impure-env
    extra-platforms = x86_64-darwin aarch64-darwin
    warn-dirty = false
    use-sqlite-wal = true
  '';

  nix.settings.trusted-users = ["nick" "root"];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.nix-index.enable = true;
}
