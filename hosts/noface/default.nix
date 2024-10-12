{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/optional/impermanence.nix
    ../common/optional/resolved.nix

    ../common/users/zach
  ];

  networking.hostName = "noface";
  system.stateVersion = "24.05";

  boot = {
    loader = {
      timeout = 5;
      systemd-boot.editor = true;
    };
    initrd.systemd.emergencyAccess = true;
  };

  specialisation.debug.configuration = {
    system.nixos.tags = ["debug" "serial-console"];

    boot.kernelParams = [
      "systemd.setenv=SYSTEMD_SULOGIN_FORCE=1"
      "systemd.show_status=true"
      "systemd.log_level=debug"
      "systemd.log_target=console"
      "systemd.journald.forward_to_console=1"

      "log_buf_len=1M"
      "console=tty0"
      "console=ttyS0,115200"

      "boot.trace"
      "boot.shell_on_fail"
    ];
  };

  console.earlySetup = false;
}
