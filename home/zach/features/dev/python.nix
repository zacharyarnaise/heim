{pkgs, ...}: {
  home.packages = [
    pkgs.gcc
    pkgs.python312
    pkgs.python312Packages.pip
  ];
}
