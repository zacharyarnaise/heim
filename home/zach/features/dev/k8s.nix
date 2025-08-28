{
  pkgs,
  lib,
  config,
  ...
}: let
  mkReposSet = repos:
    lib.mapAttrsToList (rname: rurl: {
      name = rname;
      url = rurl;
    })
    repos;
  helmRepos = {
    "stable" = "https://charts.helm.sh/stable";
    "bitnami" = "https://charts.bitnami.com/bitnami";
    "ingress-nginx" = "https://kubernetes.github.io/ingress-nginx";
    "redpanda" = "https://charts.redpanda.com";
    "sentry" = "https://sentry-kubernetes.github.io/charts";
    "jetstack" = "https://charts.jetstack.io";
  };
in {
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
        splashless = true;
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
      k3d
      ;
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    k = "kubecolor";
    kcx = "kubectx";
    kns = "kubens";
  };

  xdg.configFile."helm/repositories.yaml".text = lib.generators.toYAML {} {
    repositories = mkReposSet helmRepos;
  };
}
