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

      gaa = "git add --all";
      gain = "git add --interactive";
      gapa = "git add --patch";
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
      grh = "git reset --hard";
      grk = "git reset --keep";
      grs = "git reset --soft";
      grhh = "git reset --hard HEAD";
      grkh = "git reset --keep HEAD";
      grsh = "git reset --soft HEAD";
      gsm = "git switch main";
      gst = "git status";
    }
    // lib.optionalAttrs (hasPkg "kubectl") {
      k = "kubectl";
      kn = "kubens";
      kx = "kubectx";
    };
}
