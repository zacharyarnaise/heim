{pkgs, ...}: {
  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };
    etc."libva.conf".text = ''
      LIBVA_MESSAGING_LEVEL=1
    '';
  };

  boot = {
    blacklistedKernelModules = ["nouveau"];
    extraModprobeConfig = ''
      options nvidia "NVreg_UsePageAttributeTable=1"
    '';
  };

  hardware = {
    nvidia = {
      nvidiaSettings = false;
      open = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };

    graphics = {
      extraPackages = [pkgs.nvidia-vaapi-driver];
      extraPackages32 = [pkgs.pkgsi686Linux.nvidia-vaapi-driver];
    };
  };
}
