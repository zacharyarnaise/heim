{lib, ...}: {
  boot.loader.systemd-boot = {
    enable = true;

    configurationLimit = lib.mkDefault 10;
    consoleMode = "max";
    editor = lib.mkDefault false;
  };
}
