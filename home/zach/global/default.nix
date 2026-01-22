{
  lib,
  config,
  hostSpec,
  ...
}: {
  imports =
    (map lib.custom.relativeToRoot ["modules/home-manager" "modules/common"])
    ++ [
      # Unused for now
      #./secrets.nix

      ../features/cli/common
      ../features/cli/fish
      ../features/cli/zsh
    ];

  inherit hostSpec;

  programs = {
    home-manager.enable = true;
  };

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "25.11";
    username = "zach";
    homeDirectory = "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];

    persistence."/persist" = {
      directories = lib.optionals (hostSpec.kind != "headless") [
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        "Code"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };
  };
}
