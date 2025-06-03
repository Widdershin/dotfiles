{ inputs, pkgs, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nixVersions.latest;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowAliases = true;

  # Enable flake and nix commmand support, and x86 platform support
  nix.extraOptions = ''
    experimental-features = flakes nix-command configurable-impure-env
    extra-platforms = x86_64-darwin aarch64-darwin
    warn-dirty = false
    use-sqlite-wal = true
  '';

  nix.settings.trusted-users = ["nick" "root"];
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.nix-index.enable = true;
}
