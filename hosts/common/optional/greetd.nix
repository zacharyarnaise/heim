{config, ...}: {
  programs.uwsm = {
    enable = true;

    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      prettyName = "Hyprland";
      comment = "Hyprland managed by UWSM";
    };
  };

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${config.programs.uwsm.package}/bin/uwsm start hyprland-uwsm.desktop";
        user = "greeter";
      };
      initial_session = {
        command = "${config.programs.uwsm.package}/bin/uwsm start hyprland-uwsm.desktop";
        user = "greeter";
      };
    };
  };
}
