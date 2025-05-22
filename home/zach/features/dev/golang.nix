{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;

    goPath = ".go";
    goBin = ".go/bin";
    goPrivate =
      if config.hostSpec.isWork
      then inputs.secrets.work.goPrivate
      else {};
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      gopls
      gotools
      go-tools
      ;
  };
}
