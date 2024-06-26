{
  config,
  lib,
  ...
}: {
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;
  systemd.services.tlp = lib.mkIf (config.services.tlp.enable) {
    after = ["powertop.service"];
  };
}
