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
