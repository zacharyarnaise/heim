{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./gtk.nix
    ./pass.nix
    ./qt.nix
    ./stylix.nix
    ./wayland.nix
    ./xdg.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      nautilus
      overskride
      pwvucontrol
      qalculate-qt
      ;
  };

  services.yubikey-touch-detector.enable = true;
}
