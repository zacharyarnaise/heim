{
  pkgs,
  lib,
  ...
}: {
  home.packages = [pkgs.vesktop];

  stylix.targets.vesktop.enable = true;

  home.persistence = {
    "/persist" = {
      directories = [
        ".config/Vencord/settings"
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
  };

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
