{
  config,
  inputs,
  ...
}: let
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets.hosts."jiji";

  peersNames = builtins.attrNames flakeSecrets.wg.peers;
in {
  sops.secrets = let
    names = ["wg/pk"] ++ map (p: "wg/peers/${p}/psk") peersNames;
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
    wireguard = {
      enable = true;
      interfaces.wg0 = {
        type = "wireguard";
        ips = ["10.0.0.1/24"];
        listenPort = flakeSecrets.wg.port;
        mtu = 1420;
        privateKeyFile = sopsSecrets."wg/pk".path;
        peers =
          map (n: {
            inherit (flakeSecrets.wg.peers.${n}) allowedIPs publicKey;
            presharedKeyFile = sopsSecrets."wg/peers/${n}/psk".path;
          })
          peersNames;
      };
    };
    firewall = {
      allowedUDPPorts = [flakeSecrets.wg.port];
    };
  };
}
