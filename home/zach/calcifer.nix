{
  imports = [
    ./global

    ./features/de/common
    ./features/de/hyprland
    ./features/de/apps

    ./features/dev
  ];

  monitors = [
    {
      name = "DP-3";
      width = 3840;
      height = 2160;
      refreshRate = 144;
      workspace = "4";
      primary = true;
    }
    {
      name = "DP-2";
      width = 3840;
      height = 2160;
      workspace = "1";
      primary = false;
      position = "2160x0";
      extraArgs = "transform,1";
    }
  ];

  wayland.windowManager.hyprland.settings.device = [
    {
      name = "logitech-usb-receiver-mouse";
      accel_profile = "adaptive";
      sensitivity = 0.2;
    }
  ];
}
