{
  description = "Anand Magaji system configuration";
  inputs = {
    # monorepo w/ recipes ("derivations")
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      ...
    }@inputs:
    let
      # Override at switch time: PRIMARY_USER=... ./scripts/switch-*.sh (requires --impure)
      primaryUser =
        let
          u = builtins.getEnv "PRIMARY_USER";
        in
        if u == "" then "amagaji" else u;
    in
    {
      # macOS — apply with: ./scripts/switch-mac.sh [username] [hostname]
      darwinConfigurations."macpro-m2" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          ./hosts/macpro-m2/configuration.nix
        ];
        specialArgs = {
          inherit inputs self primaryUser;
        };
      };

      # NixOS — apply with: ./scripts/switch-linux.sh [username] [hostname]
      nixosConfigurations."tp14s" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos
          ./hosts/tp14s/configuration.nix
        ];
        specialArgs = {
          inherit inputs self primaryUser;
        };
      };
    };
}
