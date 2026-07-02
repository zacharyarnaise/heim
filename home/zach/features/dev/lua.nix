{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      lua5_5
      luau
      luau-lsp
      selene
      stylua
      ;
  };
}
