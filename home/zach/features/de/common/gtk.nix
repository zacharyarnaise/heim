{pkgs, ...}: {
  gtk = let
    commonExtraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-decoration-layout = "appmenu";
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-error-bell = 0;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  in {
    enable = true;

    gtk3.extraConfig = commonExtraConfig;
    gtk4.extraConfig = commonExtraConfig;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
