{
  inputs,
  lib,
  config,
  hostSpec,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot ["modules/home-manager" "modules/common"])
    ++ [
      inputs.impermanence.homeManagerModules.impermanence

      # Unused for now
      #./secrets.nix

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
    stateVersion = "25.05";
    username = "zach";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];

    persistence."/persist" = {
      directories = lib.optionals (hostSpec.kind != "headless") [
        ".local/share/keyrings"
        "Code"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };
  };
}
