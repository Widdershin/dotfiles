{
  description = "Nick's macOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations."Nicks-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        # core system config
        ./nix/nix-settings.nix
        ./nix/darwin-settings.nix
        ./nix/shell-configuration.nix
        ./nix/fonts.nix

        # packages
        ./nix/system-packages.nix
        ./nix/homebrew.nix
        ./nix/neovim.nix

        # services
        ./nix/tmux.nix
        ./nix/tailscale.nix
      ];

      specialArgs = { inherit inputs; };
    };
  };
}
