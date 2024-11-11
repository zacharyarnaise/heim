{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  hostName = config.networking.hostName;
  secrets = config.sops.secrets;
  secretsDir = builtins.toString inputs.secrets;
in {
  home-manager.users.zach = import ../../../../home/zach/${hostName}.nix;

  users.users.zach = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "audio"
        "video"
        "wheel"
      ]
      ++ ifTheyExist [
        "network"
        "vboxsf"
      ];

    hashedPasswordFile = secrets.user."passwords/${hostName}".path;
    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile "${secretsDir}/users/zach/id_ed25519.pub");
  };
}
