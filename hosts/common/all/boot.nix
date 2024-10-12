{
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    plymouth.enable = false;

    loader = {
      timeout = lib.mkDefault 3;
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
        consoleMode = "max";
        editor = lib.mkDefault false;
      };
    };
  };

  console.earlySetup = lib.mkDefault true;
}
