{
  config,
  inputs,
  ...
}: let
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets.hosts."kamaji";
in {
  sops.secrets = {
    "wg1/pk" = {
      group = "systemd-network";
      mode = "0440";
    };
  };

  networking = {
    wireguard = {
      enable = true;
      interfaces.wg1 = {
        type = "wireguard";
        ips = ["10.0.0.1/24"];
        listenPort = flakeSecrets.wg1.port;
        mtu = 1420;
        privateKeyFile = sopsSecrets."wg1/pk".path;
        inherit (flakeSecrets.wg1) peers;
      };
    };
    firewall = {
      allowedUDPPorts = [flakeSecrets.wg1.port];
    };
  };
}
