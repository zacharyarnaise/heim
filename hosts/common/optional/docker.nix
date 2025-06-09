{lib, ...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;

    autoPrune.enable = true;
    autoPrune.dates = "monthly";
    logDriver = "local";
    extraOptions = lib.concatStringsSep " " [
      "--log-level=warn"
      "--log-opt max-size=10m"
      "--log-opt max-file=1"
      "--log-opt compress=false"
    ];
  };
}
