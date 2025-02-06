{lib, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = false;
      splash = false;
    };
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      After = lib.mkForce "graphical-session.target";
    };
  };
}
