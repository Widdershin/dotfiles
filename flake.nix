{
  description = "Nick's darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;

        # Enable flake and nix commmand support, and x86 platform support
        nix.extraOptions = ''
          experimental-features = flakes nix-command
          extra-platforms = x86_64-darwin aarch64-darwin
        '';

        nix.settings.trusted-users = ["nick" "root"];

        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowAliases = true;
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      darwinConfigurations."Nicks-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./nix/darwin-settings.nix
          ./darwin-configuration.nix
          ./nix/homebrew.nix
          ./nix/system-packages.nix
          ./nix/neovim.nix
        ];
      };
    };
}
