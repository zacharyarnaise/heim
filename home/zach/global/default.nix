{
  inputs,
  lib,
  hostSpec,
  ...
}: let
  homePath = "/home/zach";
  homeDirectories = ["Code" "Documents" "Downloads" "Pictures" "Videos"];
in {
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
    homeDirectory = homePath;
    sessionPath = ["$HOME/.local/bin"];

    persistence."/persist${homePath}" = {
      allowOther = false;
      defaultDirectoryMethod = "symlink";
      directories = lib.optionals (hostSpec.kind != "headless") homeDirectories;
    };
  };
  systemd.user.tmpfiles.rules = lib.mkIf (hostSpec.kind != "headless") (
    lib.lists.forEach homeDirectories
    (dir: "d /persist${homePath}/${dir} 0750 zach zach - -")
  );
}
