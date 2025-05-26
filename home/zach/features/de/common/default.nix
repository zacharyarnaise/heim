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
      kalker
      overskride
      pavucontrol
      ;
  };

  services.yubikey-touch-detector.enable = true;
}
