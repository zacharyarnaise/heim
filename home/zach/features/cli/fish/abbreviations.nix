{
  lib,
  config,
  ...
}: let
  hasPkg = pkg: lib.custom.has pkg config.home.packages;
in {
  programs.fish.shellAbbrs =
    {
      "-" = "cd -";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      cp = "cp -iv";
      grep = "grep --color=auto --exclude-dir={.git,.venv,venv}";
      md = "mkdir -p";
      mv = "mv -iv";
      ns = "nix-shell";
      rd = "rmdir";
      rm = "rm -iv";
    }
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
    }
    // lib.optionalAttrs (hasPkg "kubectl") {
      k = "kubectl";
      kn = "kubens";
      kx = "kubectx";
    };
}
