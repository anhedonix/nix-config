{ primaryUser, ... }:
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
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";
  };
}
