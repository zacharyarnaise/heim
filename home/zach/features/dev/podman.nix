{
  pkgs,
  osConfig,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      dive
      podman-tui
      ;
  };

  services.podman.package = osConfig.virtualisation.podman.package;
}
