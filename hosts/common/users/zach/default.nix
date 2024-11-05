{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  secretsDir = builtins.toString inputs.secrets;
  hostname = config.networking.hostName;
in {
  home-manager.users.zach = import ../../../../home/zach/${hostname}.nix;

  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = [
      "network"
      "wheel"
    ];

    hashedPasswordFile = config.sops.secrets."zach/password".path;
    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile "${secretsDir}/users/zach/id_ed25519.pub");
    packages = [pkgs.home-manager];
  };

  sops.secrets = {
    "zach/password".neededForUsers = true;
    "zach/age_keys.txt" = {
      owner = "zach";
      group = "zach";
      mode = "0400";
      path = "/home/zach/.config/sops/age/keys.txt";
    };
  };
}
