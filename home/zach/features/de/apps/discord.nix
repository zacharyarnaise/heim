{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = [pkgs.vesktop];

  stylix.targets.vesktop.enable = true;

  home.persistence = {
    "/persist${config.home.homeDirectory}" = {
      directories = [
        ".config/Vencord/settings"
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
  };
  systemd.user.tmpfiles.rules = [
    "d /persist/home/zach/.config/vesktop/sessionData 0750 zach - -"
    "d /persist/home/zach/.config/vesktop/settings 0750 zach - -"
  ];

  xdg.configFile = {
    "vesktop/settings.json".text = lib.generators.toJSON {} {
      aRPC = false;
      discordBranch = "stable";
      minimizeToTray = true;
    };
    "vesktop/state.json".text = lib.generators.toJSON {} {
      firstLaunch = false;
    };
  };
}
