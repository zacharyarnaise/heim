{
  pkgs,
  lib,
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
    "datadog" = "https://helm.datadoghq.com";
    "traefik" = "https://traefik.github.io/charts";
    "oauth2-proxy" = "https://oauth2-proxy.github.io/manifests";
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
        textWrap = true;
        showTime = true;
      };
    };

    plugins = {
      stern = {
        shortCut = "Ctrl-L";
        confirm = false;
        description = "Logs (stern)";
        scopes = ["pods"];
        command = "stern";
        background = false;
        args = [
          "$FILTER"
          "--context=$CONTEXT"
          "--namespace=$NAMESPACE"
          "--tail=-1"
          "--template={{color .PodColor .PodName}} {{.Message}}\n"
        ];
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
      stern
      ;
  };

  xdg.configFile."helm/repositories.yaml".text = lib.generators.toYAML {} {
    repositories = mkReposSet helmRepos;
  };
}
