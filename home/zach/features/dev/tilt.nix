{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      tilt
      ;
  };

  home.file.".tilt-dev/analytics/user/choice.txt".text = "opt-out";

  systemd.user.services."tilt-prune-images" = {
    Unit = {
      Description = "Tilt image prune service";
      RequiresMountsFor = "%t/containers";
    };
    Service = {
      ExecStart = "${pkgs.podman}/bin/podman image prune -a -f --external --filter label=dev.tilt.gc=true --filter until=1h";
      Type = "oneshot";
    };
    Install.WantedBy = ["default.target"];
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
