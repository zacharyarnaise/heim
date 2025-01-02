{config, ...}: let
  secrets = config.sops.secrets;
in {
  sops.secrets = {
    "wireless/secrets" = {};
    "wireless/wf1" = {};
  };

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
      ap_scan=1
      p2p_disabled=1
      interworking=0
      wps_cred_add_sae=1
      pmf=1
      sae_pwe=2
    '';

    secretsFile = secrets."wireless/secrets".path;
    networks = {
      "${secrets."wireless/wf1"}" = {
        pskRaw = "ext:wf1";
      };
    };
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
