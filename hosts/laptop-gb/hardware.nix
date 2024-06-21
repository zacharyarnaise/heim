{lib, ...}: {
  boot = {
    kernelModules = ["kvm-amd"];
    # Improve battery life by running full tickless on the last 4 cores
    kernelParams = ["nohz_full=4-7"];
  };

  nix.settings.max-jobs = 8;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;

  swapDevices = lib.mkForce [];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
