{
  lib,
  config,
  ...
}: {
  services.displayManager.sessionPackages = lib.flatten (
    lib.mapAttrsToList (_: v: v.home.displaySessions) config.home-manager.users
  );
}
