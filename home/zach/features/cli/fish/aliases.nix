{
  lib,
  config,
  ...
}: let
  hasPkg = pkg: lib.custom.has pkg (map (p: p.pname or p.name) config.home.packages);
in {
  programs.fish.shellAliases =
    {}
    // lib.optionalAttrs (hasPkg "bat") {
      cat = "bat";
      diff = "batdiff";
      man = "batman";
      rg = "batgrep";
    }
    // lib.optionalAttrs (hasPkg "eza") {
      l = "eza -la";
      la = "eza -la";
      ll = "eza -l";
      ls = "eza -l";
    };
}
