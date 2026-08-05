{
  lib,
  pkgs,
  primaryUser,
  ...
}:
{
  imports = [
    ./packages.nix
    ./git.nix
    ./git-signing.nix
    ./shell.nix
    ./mise.nix
    ./fonts.nix
  ];

  home = {
    username = primaryUser;
    homeDirectory = lib.mkDefault (
      if pkgs.stdenv.hostPlatform.isDarwin then
        "/Users/${primaryUser}"
      else
        "/home/${primaryUser}"
    );
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}
