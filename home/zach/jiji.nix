{pkgs, ...}: {
  imports = [
    ./global

    ./features/cli/optional/beets.nix
  ];

  home.packages = [
    pkgs.brightnessctl
  ];
}
