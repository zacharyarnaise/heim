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

    kernelParams = [
      "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1"
    ];
  };

  system.stateVersion = "24.05";
}
