{
  lib,
  config,
  ...
}: let
  hasPkg = pkg: lib.custom.has pkg (map (p: p.pname or p.name) config.home.packages);
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

      gcam = "git commit -am";
      gcl = "git clone";
      gcp = "git cherry-pick";
      gl = "git pull";
      gm = "git merge";
      gma = "git merge --abort";
      gmc = "git merge --continue";
      gp = "git push";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      grhh = "git reset --hard";
      gsm = "git switch main";
      gst = "git status";
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
