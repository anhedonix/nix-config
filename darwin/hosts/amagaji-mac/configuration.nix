{
  pkgs,
  primaryUser,
  ...
}:
{
  networking.hostName = "amagaji-mac";

  # host-specific homebrew casks
  homebrew.casks = [
    # --- Messaging ---
    # "slack" # team chat (use slack@beta in darwin/homebrew.nix)
  ];

  # host-specific home-manager configuration
  home-manager.users.${primaryUser} = {
    home.packages = with pkgs; [
      # --- Editors ---
      emacs-macport # Yamamoto Mac port Emacs (provides `emacs` for Doom)

      # --- Git & GitHub ---
      # graphite-cli # stacked PR workflow CLI
    ];

    programs = {
      zsh = {
        initContent = ''
          # Source shell functions
          source ${./shell-functions.sh}
        '';
      };
    };
  };
}
