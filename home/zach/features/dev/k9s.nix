{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.k9s = {
    enable = true;

    settings.k9s = {
      liveViewAutoRefresh = true;
      refreshRate = 2;
      maxConnRetry = 5;
      skipLatestRevCheck = true;
      ui = {
        logoless = true;
        crumbsless = true;
        defaultsToFullScreen = true;
      };
      logger = {
        buffer = 5000;
        tail = 300;
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      kubectl
      kubernetes-helm
      kubecolor
      kubectx
      ;
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    k = "kubecolor";
    kcx = "kubectx";
    kns = "kubens";
  };
}
