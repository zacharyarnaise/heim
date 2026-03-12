{
  config,
  lib,
  ...
}: {
  services.tlp = {
    enable = true;
    settings = {
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 3;
      AMDGPU_ABM_LEVEL_ON_SAV = 3;
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_SAV = "power";
      CPU_DRIVER_OPMODE_ON_AC = "guided";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_DRIVER_OPMODE_ON_SAV = "active";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      PLATFORM_PROFILE_ON_SAV = "low-power";

      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;
      USB_EXCLUDE_PHONE = 1;
    };
  };

  systemd.services.tlp = lib.mkIf config.services.tlp.enable {
    after = ["powertop.service"];
  };
}
