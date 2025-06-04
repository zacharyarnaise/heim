{pkgs, ...}: {
  imports = [
    ./clipse.nix
    ./gtk.nix
    ./mako.nix
    ./pass.nix
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
      qalculate-qt
      ;
  };

  services.yubikey-touch-detector.enable = true;
}
