{
  description = "Anand Magaji macOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.url = "github:Homebrew/brew/master";
    };
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
      primaryUser = "amagaji";
    in
    {
      darwinConfigurations."amagaji-mac" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./default.nix
          ./hosts/amagaji-mac/configuration.nix
        ];
        specialArgs = {
          inherit inputs self primaryUser;
        };
      };
    };
}
