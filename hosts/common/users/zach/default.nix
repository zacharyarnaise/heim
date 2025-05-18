{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  inherit (config.sops) secrets;
  secretsDir = builtins.toString inputs.secrets;
in {
  home-manager.users.zach =
    import ../../../../home/zach/${config.hostSpec.name}.nix;

  programs.zsh.enable = true;

  users.groups.zach = {};
  users.users.zach = {
    packages = [pkgs.home-manager];
    isNormalUser = true;
    shell = pkgs.zsh;
    group = "zach";
    extraGroups =
      [
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "video"
        "network"
        "docker"
      ];

    password = lib.mkForce null;
    hashedPasswordFile = secrets."passwords/zach".path;
    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile "${secretsDir}/users/zach/id_zach_sk.pub");
  };

  environment.persistence."/persist".users.zach = {
    directories = lib.mkIf (config.hostSpec.kind != "headless") [
      {
        directory = ".config/sops";
        mode = "0700";
      }
      {
        directory = ".gnupg/private-keys-v1.d";
        mode = "0750";
      }
      {
        directory = ".kube";
        mode = "0700";
      }
      {
        directory = ".mozilla/firefox/default";
        mode = "0750";
      }
    ];
  };

  security.pam.services = {
    hyprlock = {};
  };
}
