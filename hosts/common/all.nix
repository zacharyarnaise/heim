# Configuration applicable to all hosts
{
  imports = [
    ./shared
    ./shared/boot.nix
    ./shared/nix-daemon.nix
    ./shared/resolved.nix
    ./shared/security.nix
  ];

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    nixos.enable = false;
    info.enable = false;
  };

  hardware = {
    enableAllFirmware = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  time.timeZone = "Europe/Paris";
}
