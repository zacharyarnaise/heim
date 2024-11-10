{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.home-manager.impermanence
      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    username = "zach";
    homeDirectory = "/home/zach";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/heim";
    };

    persistence."/persist/home/zach" = {
      directories = [
        ".local/share/nix" # trusted settings and repl history
        "heim"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };

    stateVersion = "24.05";
  };
}
