{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.wpa_supplicant
  ];

  networking.wireless = {
    enable = true;
    allowAuxiliaryImperativeNetworks = true;

    fallbackToWPA2 = false;
    scanOnLowSignal = false;
    extraConfig = ''
      ap_scan=1
      p2p_disabled=1
      interworking=0
      wps_cred_add_sae=1
      pmf=1
      sae_pwe=2
    '';
  };
}
