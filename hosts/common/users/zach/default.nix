{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  hostName = config.networking.hostName;
  secrets = config.sops.secrets;
  secretsDir = builtins.toString inputs.secrets;
in {
  home-manager.users.zach = import ../../../../home/zach/${hostName}.nix;

  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = [
      "network"
      "wheel"
    ];

    hashedPasswordFile = secrets.user."passwords/${hostName}".path;
    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile "${secretsDir}/users/zach/id_ed25519.pub");
    packages = [pkgs.home-manager];
  };
}
