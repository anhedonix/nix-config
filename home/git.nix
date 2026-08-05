{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "anhedonix";
    userEmail = "anhedonix@gmail.com";

    lfs.enable = true;

    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519_github_signing";
      signByDefault = true;
    };

    ignores = [ "**/.DS_STORE" ];

    extraConfig = {
      github = {
        user = "anhedonix";
      };
      init = {
        defaultBranch = "master";
      };
    };
  };
}
