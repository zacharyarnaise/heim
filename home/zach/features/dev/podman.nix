{
  pkgs,
  osConfig,
  ...
}: let
  podmanPkg = osConfig.virtualisation.podman.package;
  toml = pkgs.formats.toml {};
in {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      dive
      podman-tui
      ;
  };

  services.podman.package = podmanPkg;
  # Socket path for tools that mount it (e.g. k3d, defaults to /var/run/docker.sock)
  home.sessionVariables.DOCKER_SOCK = "$XDG_RUNTIME_DIR/podman/podman.sock";
  xdg.configFile."containers/registries.conf".source = toml.generate "registries.conf" {
    unqualified-search-registries = ["docker.io"];
    registry = [
      {
        location = "docker.io";
        mirror = [{location = "mirror.gcr.io";}];
      }
      {location = "quay.io";}
      {location = "ghcr.io";}
      {location = "gcr.io";}

      {
        location = "localhost";
        insecure = true;
      }
    ];
  };
}
