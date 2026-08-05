{
  description = "Anand Magaji NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      primaryUser = "amagaji";
    in
    {
      nixosConfigurations."tp14s" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./default.nix
          ./hosts/tp14s/configuration.nix
        ];
        specialArgs = {
          inherit inputs self primaryUser;
        };
      };
    };
}
