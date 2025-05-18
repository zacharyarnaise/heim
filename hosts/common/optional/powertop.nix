{
  config,
  lib,
  ...
}: {
  environment.persistence."/persist" = {
    directories = [
      "/var/cache/powertop"
    ];
  };

  powerManagement.powertop.enable = true;
  systemd.services.tlp = lib.mkIf config.services.tlp.enable {
    after = ["powertop.service"];
  };

  services.tlp = {
    enable = true;
    settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
}
