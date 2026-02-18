{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_26;

    telemetry.mode = "off";
    env = {
      GOPATH = "${config.home.homeDirectory}/.go";
      GOBIN = "${config.home.homeDirectory}/.go/bin";
      GOPRIVATE =
        lib.optionals config.hostSpec.isWork inputs.secrets.work.goPrivate;
    };
  };

  home.sessionPath = [config.programs.go.env.GOBIN];
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      delve
      golangci-lint
      gopls
      revive
      yaegi
      ;
  };
}
