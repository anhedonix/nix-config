{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ensure-git-ssh-signing";
      runtimeInputs = with pkgs; [
        gh
        openssh
        coreutils
      ];
      text = builtins.readFile ./scripts/ensure-git-ssh-signing.sh;
    })
  ];
}
