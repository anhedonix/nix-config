{
  lib,
  config,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/Documents/GitHub/nix-config";
  wallpaper = "${flakeDir}/common/wallpaper/VEXiL_Wallpaper.jpg";
in
{
  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -f "${wallpaper}" ]; then
      /usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "${wallpaper}"'
    fi
  '';
}
