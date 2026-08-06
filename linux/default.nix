{
  pkgs,
  inputs,
  self,
  primaryUser,
  ...
}:
{
  imports = [
    ./settings.nix
    ./podman.nix
    ./flatpak.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  users.users.${primaryUser} = {
    isNormalUser = true;
    home = "/home/${primaryUser}";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "podman"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    users.${primaryUser} = {
      imports = [
        ../common
        ./home
      ];
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };
}
