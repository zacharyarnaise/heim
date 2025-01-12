{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./mako.nix
    ./qt.nix
    ./stylix.nix
    ./wayland.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
  ];
}
