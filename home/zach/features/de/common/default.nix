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
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      overskride
      pwvucontrol
      qalculate-qt
      ;
  };

  services.yubikey-touch-detector.enable = true;
}
