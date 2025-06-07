{
  heimRev,
  config,
  ...
}: {
  system.configurationRevision = heimRev;
  system.nixos.label = "${config.system.nixos.version}_${heimRev}";
}
