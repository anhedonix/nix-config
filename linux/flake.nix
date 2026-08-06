{
  description = "Anand Magaji NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      ...
    }@inputs:
    let
      primaryUser = "amagaji";
    in
    {
      nixosConfigurations."tp14s" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./default.nix
          ./hosts/tp14s/configuration.nix
        ];
        specialArgs = {
          inherit inputs self primaryUser;
        };
      };
    };
}
