{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.sops-nix.homeManagerModules.sops

      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "24.05";
    username = "zach";
    homeDirectory = "/home/zach";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/heim";
    };

    persistence."/persist/home/zach" = {
      allowOther = false;
      directories = [
        ".local/share/nix" # trusted settings and repl history
        "heim"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };
  };
}
