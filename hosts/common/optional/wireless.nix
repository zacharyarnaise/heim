{
  inputs,
  config,
  ...
}: let
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets;
in {
  sops.secrets = {
    "wireless" = {};
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
    '';

    secretsFile = sopsSecrets."wireless".path;
    networks = {
      "${flakeSecrets.wireless.wf1.ssid}" = {
        pskRaw = "ext:wf1";
        authProtocols = flakeSecrets.wireless.wf1.authProtocols;
        extraConfig = flakeSecrets.wireless.wf1.extraConfig;
      };
    };
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
