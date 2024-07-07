{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.sops-nix.homeManagerModules.sops
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "zach";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];

    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          ".local/bin"
          ".local/share/nix" # trusted settings and repl history
        ];
        allowOther = true;
      };
    };

    stateVersion = "24.05";
  };

  sops = {
    defaultSopsFile = lib.dirs.secrets + "/secrets.yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
