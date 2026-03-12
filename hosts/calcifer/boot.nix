{
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [
      "kvm-intel"
      "nct6683"
      "i2c-dev"
    ];
    kernelParams = [
      "i8042.nopnp=1"
    ];

    loader.limine.extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(b98f5ad8-5c00-4c12-90aa-338547c53bf2):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
}
