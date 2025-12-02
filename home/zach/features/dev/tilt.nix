{
  pkgs,
  config,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      tilt
      ;
  };

  home.file.".tilt-dev/analytics/user/choice.txt".text = "opt-out";

  systemd.user.services."tilt-prune-images" = let
    podmanBin = "${config.services.podman.package}/bin/podman";
  in {
    Unit = {
      Description = "Tilt image prune service";
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
      ExecStart = [
        "${podmanBin} image prune -a -f --build-cache --external --filter label=dev.tilt.gc=true --filter until=1h"
        "${podmanBin} image prune -a -f --build-cache --external --filter dangling=true"
      ];
      Type = "oneshot";
    };
  };
  systemd.user.timers."tilt-prune-images" = {
    Unit.Description = "Tilt image prune timer";
    Timer = {
      OnCalendar = "hourly";
      RandomizedDelaySec = 300;
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}
