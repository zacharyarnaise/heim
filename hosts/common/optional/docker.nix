{
  config,
  lib,
  ...
}: {
  virtualisation.docker = {
    enable = true;

    autoPrune.enable = true;
    autoPrune.dates = "monthly";
  };

  virtualisation.docker.daemon.settings = lib.mkIf config.hostSpec.isWork {
    "log-level" = "error";
  };
}
