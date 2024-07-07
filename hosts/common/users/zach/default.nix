{
  config,
  lib,
  pkgs,
  ...
}: {
  sops.secrets = {
    "zach/password".neededForUsers = true;
    "zach/age_keys.txt" = {
      owner = "zach";
      group = "zach";
      mode = "0400";
      path = "/home/zach/.config/sops/age/keys.txt";
    };
  };

  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = [
      "network"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."zach/password".path;

    openssh.authorizedKeys.keys =
      lib.splitString "\n" (builtins.readFile (lib.dirs.userSecrets "zach") + "/id_ed25519.pub");

    packages = [pkgs.home-manager];
  };

  home-manager.users.zach =
    import (lib.dirs.root + "/home/zach/${config.networking.hostName}.nix");
}
