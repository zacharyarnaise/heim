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

  systemd.user = {
    services."podman-image-prune" = {
      Unit = {
        Description = "Prune unused podman images";
        RequiresMountsFor = "/persist/containers-rootless";
      };
      Service = {
        # Workaround for error: cannot setup namespace using newuidmap
        # See: https://github.com/NixOS/nixpkgs/issues/138423#issuecomment-947888673
        Environment = "PATH=/run/wrappers/bin:/run/current-system/sw/bin";
        ExecStart = "${podmanPkg}/bin/podman image prune -a -f --build-cache";
        Type = "oneshot";
      };
    };
    timers."podman-image-prune" = {
      Unit.Description = "Weekly podman image prune";
      Timer = {
        OnCalendar = "weekly";
        RandomizedDelaySec = 900;
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
