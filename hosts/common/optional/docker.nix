{
  config,
  lib,
  ...
}: {
  virtualisation.docker = {
    enable = true;

    autoPrune.enable = true;
    autoPrune.dates = "monthly";
    logDriver =
      if config.hostSpec.isWork
      then "none"
      else "journald";
  };

  virtualisation.docker.daemon.settings = lib.mkIf config.hostSpec.isWork {
    "--log-level" = "error";
  };
}
