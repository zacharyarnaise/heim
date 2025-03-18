{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      gopass
      gopass-jsonapi
      ;
  };
}
