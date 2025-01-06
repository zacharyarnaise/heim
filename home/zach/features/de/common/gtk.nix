{
  programs.dconf = {
    enable = true;
  };

  gtk = rec {
    enable = true;

    gtk3.extraConfig = {
      gtk-xft-hinting = 1;
    };
    gtk4 = {inherit (gtk3) extraConfig;};
  };
}
