{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_25;

    telemetry.mode = "off";
    env = {
      GOBIN = "go/bin";
      GOPATH = "go";
      GOPRIVATE =
        if config.hostSpec.isWork
        then inputs.secrets.work.goPrivate
        else {};
    };
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      delve
      golangci-lint
      gomodifytags
      gopls
      gotools
      go-tools
      yaegi
      ;
  };
}
