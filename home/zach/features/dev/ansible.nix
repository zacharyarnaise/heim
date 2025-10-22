{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ansible_2_18
      ansible-lint
      ;
  };
}
