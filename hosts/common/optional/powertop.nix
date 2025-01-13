{
  config,
  lib,
  ...
}: {
  environment.persistence."/persist/var/cache/powertop" = {
    files = [
      "/var/cache/powertop/saved_parameters.powertop"
      "/var/cache/powertop/saved_results.powertop"
    ];
  };

  powerManagement.powertop.enable = true;
  services.tlp.enable = true;
  systemd.services.tlp = lib.mkIf config.services.tlp.enable {
    after = ["powertop.service"];
  };
}
