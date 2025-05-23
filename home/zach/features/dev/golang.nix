{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;

    telemetry.mode = "off";
    goBin = "go/bin";
    goPath = "go";
    goPrivate =
      if config.hostSpec.isWork
      then inputs.secrets.work.goPrivate
      else {};
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      delve
      gofumpt
      golangci-lint
      gomodifytags
      gopls
      gotools
      go-tools
      ;
  };
}
