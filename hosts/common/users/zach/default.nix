{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.zach = {
    isNormalUser = true;
    shell = pkgs.zsh;
    group = "zach";
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

    password = "testing";
  };

  home-manager.users.zach =
    import ../../../../home/zach/${config.networking.hostName}.nix;
}
