{
  inputs,
  outputs,
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
        {
          directory = ".gnupg";
          mode = "0700";
        }
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
