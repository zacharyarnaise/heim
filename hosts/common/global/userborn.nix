{
  config,
  lib,
  ...
}: let
  hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.userborn = {
    enable = true;

    passwordFilesLocation = "${lib.optionalString hasOptinPersistence "/persist"}/etc";
  };
}
