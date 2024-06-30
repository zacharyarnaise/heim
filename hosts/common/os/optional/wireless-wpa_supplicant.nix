{
  networking.wireless = {
    enable = true;
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };

    fallbackToWPA2 = false;
    scanOnLowSignal = false;
    extraConfig = ''
      update_config=1
      ap_scan=1
      p2p_disabled=1
      interworking=0
      wps_cred_add_sae=1
      pmf=1
      sae_pwe=2
    '';
  };

  # Ensure group exists
  users.groups.network = {};
}
