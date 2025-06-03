{
  description = "Nick's macOS config";

  # enable cachix
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-24.11";
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
        ./nix/linux-builder.nix

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

    darwinConfigurations."Nicks-MacBook-Air" = nix-darwin.lib.darwinSystem {
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
      ];

      specialArgs = { inherit inputs; };
    };

    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  };
}
