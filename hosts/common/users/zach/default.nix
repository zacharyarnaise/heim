{config, ...}: {
  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = [
      "network"
      "wheel"
    ];
    # hashedPasswordFile = config.sops.secrets.layla-password.path;
    # TODO: remove when things are working
    password = "testing";
  };

  home-manager.users.zach =
    import ../../../../home/zach${config.networking.hostName}.nix;
}
