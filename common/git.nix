{ config, ... }:
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519_github_signing";
      signByDefault = true;
    };

    ignores = [ "**/.DS_STORE" ];

    settings = {
      user = {
        name = "anhedonix";
        email = "anhedonix@gmail.com";
      };
      github = {
        user = "anhedonix";
      };
      init = {
        defaultBranch = "master";
      };
    };
  };
}
