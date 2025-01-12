{lib, ...}: {
  services.hyprpaper = {
    enable = true;
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      After = lib.mkForce "graphical-session.target";
    };
  };
}
