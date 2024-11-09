{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports =
    [inputs.impermanence.nixosModules.home-manager.impermanence]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "zach";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/heim";
    };

    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        directories = [
          ".local/share/nix" # trusted settings and repl history
          "heim"
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
        ];
        allowOther = true;
      };
    };

    stateVersion = "24.05";
  };
}
