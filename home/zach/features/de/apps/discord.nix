{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.vesktop];

  stylix.targets.vesktop.enable = true;

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = false;
      directories = [
        ".config/Vencord/settings"
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
    "/persist/${config.home.homeDirectory}/.config/vesktop" = {
      allowOther = false;
      files = ["settings.json"];
    };
  };

  xdg.configFile."vesktop/state.json".text = ''
    {
      "firstLaunch": false
    }
  '';
}
