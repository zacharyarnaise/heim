{
  imports = [
    ./hardware.nix

    ../common/pc.nix
    ../common/users/zach

    ../common/optional/bluetooth.nix
  ];

  console.keyMap = "us-acentos";

  system.stateVersion = "24.11";
}
