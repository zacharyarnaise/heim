{pkgs, ...}: {
  gtk = let
    commonExtraConfig = {
      gtk-xft-hinting = 1;
    };
  in {
    enable = true;

    gtk3.extraConfig = commonExtraConfig;
    gtk4.extraConfig = commonExtraConfig;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
