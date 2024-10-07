{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/optional/impermanence.nix
    ../common/optional/resolved.nix

    ../common/users/zach
  ];

  networking.hostName = "noface";

  boot = {
    loader = {
      timeout = 5;
      systemd-boot.editor = true;
    };

    initrd.luks.devices = {
      "crypted" = {
        preLVM = false;
      };
    };
  };

  system.stateVersion = "24.05";
}
