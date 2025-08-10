{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ddcutil
      ;
  };

  services.wluma = {
    enable = true;
    settings = {
      als.none = {};
      output.ddcutil = [
        {
          name = "DELL S2721QSA";
          capturer = "wayland";
        }
        {
          name = "LG ULTRAGEAR+";
          capturer = "wayland";
        }
      ];
    };
  };
}
