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

  programs.fish.enable = true;

  users.groups.zach = {};
  users.users.zach = {
    packages = [pkgs.home-manager];
    isNormalUser = true;
    shell = pkgs.fish;
    group = "zach";
    uid = 1000;
    extraGroups =
      [
        "wheel"
      ]
      ++ ifTheyExist [
        "audio"
        "video"
        "network"
        "docker"
        "podman"
        "media"
      ];

    password = lib.mkForce null;
    hashedPasswordFile = secrets."passwords/zach".path;
    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile "${secretsDir}/users/zach/id_zach_sk.pub");
  };
}
