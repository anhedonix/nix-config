{ config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
  link = path: config.lib.file.mkOutOfStoreSymlink "${flakeDir}/darwin/dotfiles/${path}";
in
{
  xdg.configFile = {
    "karabiner/karabiner.json".source = link "karabiner/karabiner.json";
    "containers/containers.conf".source = link "containers/containers.conf";
  };

  home.file = {
    "Library/Application Support/Cursor/User/settings.json".source = link "cursor/settings.json";
  };
}
