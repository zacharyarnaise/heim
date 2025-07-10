{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      tilt
      ;
  };

  home.file.".tilt-dev/analytics/user/choice.txt".text = "opt-out";
}
