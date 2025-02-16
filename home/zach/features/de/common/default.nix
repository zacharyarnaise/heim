{pkgs, ...}: {
  imports = [
    ./cliphist.nix
    ./gtk.nix
    ./mako.nix
    ./qt.nix
    ./stylix.nix
    ./wayland.nix
    ./xdg.nix

    ./easyeffects.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      overskride
      pavucontrol
      ;
  };
}
