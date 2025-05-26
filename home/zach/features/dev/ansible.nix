{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ansible
      ansible-lint
      ;
  };
}
