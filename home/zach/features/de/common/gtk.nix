{pkgs, ...}: {
  gtk = rec {
    enable = true;

    gtk3.extraConfig = {
      gtk-xft-hinting = 1;
    };
    gtk4 = {inherit (gtk3) extraConfig;};
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
