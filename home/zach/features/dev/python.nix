{pkgs, ...}: {
  home.packages = [
    pkgs.gcc
    pkgs.python313
    pkgs.python313Packages.pip
  ];
}
