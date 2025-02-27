{
  inputs,
  outputs,
  hostSpec,
  ...
}: {
  imports =
    [
      inputs.impermanence.homeManagerModules.impermanence

      ./secrets.nix

      ../features/cli/common
      ../features/cli/zsh
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

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
      FLAKE = "$HOME/.nix-heim/heim";
    };

    persistence."/persist/home/zach" = {
      allowOther = false;
      directories = [
        ".local/share/nix" # trusted settings and repl history
        ".nix-heim"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
      ];
    };
  };
}
