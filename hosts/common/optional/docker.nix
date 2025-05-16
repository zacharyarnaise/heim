{config, ...}: {
  virtualisation.docker = {
    enable = true;

    autoPrune.enable = true;
    autoPrune.dates = "monthly";
    logDriver =
      if config.hostSpec.isWork
      then "none"
      else "journald";
  };
}
