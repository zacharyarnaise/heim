{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      alejandra
      nil
      statix
      ;
  };
}
