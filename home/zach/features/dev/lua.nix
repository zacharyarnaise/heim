{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      lua
      luau
      luau-lsp
      selene
      stylua
      ;
  };
}
