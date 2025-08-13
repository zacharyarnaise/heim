{
  config,
  inputs,
  ...
}: let
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets.hosts."kamaji";

  peersNames = builtins.attrNames flakeSecrets.wg.peers;
in {
  sops.secrets = let
    names = ["wg/pk"];
  in
    builtins.listToAttrs (map (name: {
        inherit name;
        value = {
          group = "systemd-network";
          mode = "0440";
        };
      })
      names);

  networking = {
    wg-quick.interfaces.wg0 = {
      type = "wireguard";
      address = ["10.2.0.2/32"];
      listenPort = flakeSecrets.wg.port;
      mtu = 1380;
      privateKeyFile = sopsSecrets."wg/pk".path;
      peers =
        map (n: {
          inherit (flakeSecrets.wg.peers.${n}) endpoint publicKey allowedIPs;
        })
        peersNames;
    };
    firewall = {
      allowedUDPPorts = [flakeSecrets.wg.port];
    };
  };
}
