{
  lib,
  config,
  primaryUser,
  ...
}:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./git-signing.nix
    ./shell.nix
    ./dotfiles.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";

    # Keep HM's profile dir present (Determinate Nix may not create the global one).
    activation.ensureNixProfilesDir = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      mkdir -p "${config.xdg.stateHome}/nix/profiles"
    '';
  };
}
