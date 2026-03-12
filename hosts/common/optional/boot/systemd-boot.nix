{lib, ...}: {
  boot.loader = {
    grub.enable = lib.mkForce false;
    systemd-boot = {
      enable = true;

      configurationLimit = lib.mkDefault 10;
      consoleMode = "max";
      editor = lib.mkDefault false;
    };
  };
}
