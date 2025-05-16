{lib, ...}: {
  virtualisation.docker = {
    enable = true;

    autoPrune.enable = true;
    autoPrune.dates = "monthly";
    logDriver = "local";
    extraOptions = lib.concatStringsSep " " [
      "log-opt max-size=10m"
      "log-opt max-file=1"
    ];
  };
}
