{
  imports = [
    ./global

    ./features/de/common
    ./features/de/hyprland
    ./features/de/apps
    ./features/de/services/wluma.nix

    ./features/dev
  ];

  monitors = [
    {
      name = "DP-3";
      width = 3840;
      height = 2160;
      refreshRate = 144;
      workspaces = ["1" "2" "3" "4" "5" "6" "7"];
      primary = true;
    }
    {
      name = "DP-2";
      width = 3840;
      height = 2160;
      workspaces = ["8" "9" "10"];
      primary = false;
      position = "2160x-685";
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
