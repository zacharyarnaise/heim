{
  inputs,
  lib,
  hostSpec,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot ["modules/home-manager" "modules/common"])
    ++ [
      inputs.impermanence.homeManagerModules.impermanence

      ./secrets.nix

      ../features/cli/common
      ../features/cli/zsh
    ];

  inherit hostSpec;

  programs = {
    home-manager.enable = true;
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "24.11";
    username = "zach";
    homeDirectory = "/home/zach";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Code/Nix/heim";
    };

    persistence."/persist/home/zach" = {
      allowOther = false;
      defaultDirectoryMethod = "symlink";
      directories = [
        ".local/share/nix" # trusted settings and repl history
        "Code"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };
  };
}
