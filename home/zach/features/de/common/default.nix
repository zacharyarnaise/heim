{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./foot.nix
    ./gtk.nix
    ./pass.nix
    ./qt.nix
    ./rofi.nix
    ./stylix.nix
    ./wayland.nix
    ./xdg.nix
    ./yubikey.nix
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
