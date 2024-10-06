{
  imports = [
    ./hardware.nix

    ../common/headless.nix
    ../common/optional/impermanence.nix
    ../common/optional/resolved.nix

    ../common/users/zach
  ];

  networking.hostName = "noface";

  loader = {
    timeout = 5;
    systemd-boot.editor = true;
  };

  system.stateVersion = "24.05";
}
