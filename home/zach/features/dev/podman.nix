{
  pkgs,
  osConfig,
  ...
}: let
  podmanPkg = osConfig.virtualisation.podman.package;
in {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      dive
      podman-tui
      ;
  };

  services.podman.package = podmanPkg;
  systemd.user.services."podman-prune" = let
    podmanBin = "${podmanPkg}/bin/podman";
  in {
    Unit = {
      Description = "Podman prune service";
      RequiresMountsFor = "/persist/containers-rootless";
    };
    Service = {
      # Workaround for error: cannot setup namespace using newuidmap
      # See: https://github.com/NixOS/nixpkgs/issues/138423#issuecomment-947888673
      Environment = "PATH=${
        builtins.concatStringsSep ":" [
          "/run/wrappers/bin"
          "/run/current-system/sw/bin"
        ]
      }";
      ExecStart = "${podmanBin} system prune -a -f --build --volumes";
      Type = "oneshot";
    };
  };
  systemd.user.timers."podman-prune" = {
    Unit.Description = "Podman prune timer";
    Timer = {
      OnCalendar = "weekly";
      RandomizedDelaySec = 900;
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
