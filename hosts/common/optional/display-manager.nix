{pkgs, ...}: {
  programs.gdk-pixbuf.modulePackages = [pkgs.librsvg];

  services = {
    displayManager = {
      enable = true;

      ly = {
        enable = true;
        x11Support = false;
        settings = {
          animation = "doom";
          auth_fails = 3;
          clear_password = true;
          hide_key_hints = true;
          hide_keyboard_locks = true;
          hide_version_string = true;
          initial_info_text = "wake up...";
          min_refresh_delta = 35;
          save = true;
        };
      };
    };
    seatd.enable = true;
  };
  environment.persistence."/persist" = {
    files = [
      {
        file = "/etc/ly/save.txt";
        parentDirectory = {mode = "0755";};
      }
    ];
  };
}
