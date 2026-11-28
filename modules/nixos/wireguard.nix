{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.heim.wireguard;
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets.hosts.${config.hostSpec.name};

  peersNames = builtins.attrNames flakeSecrets.wg.peers;
in {
  options.heim.wireguard = {
    enable = lib.mkEnableOption "wg0 WireGuard interface";
    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this is a 'server' (no endpoints, peers connect to it)";
    };
  };

  config = lib.mkIf cfg.enable {
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
          ips = ["${config.heim.net.wg.${config.hostSpec.name}}/24"];
          listenPort = flakeSecrets.wg.port;
          # Laptop may use tethered connections, keep headroom to avoid fragmentation
          mtu =
            if config.hostSpec.isLaptop
            then 1380
            else 1420;
          privateKeyFile = sopsSecrets."wg/pk".path;
          peers =
            map (n: {
              inherit (flakeSecrets.wg.peers.${n}) allowedIPs publicKey;
              endpoint =
                if cfg.isServer
                then null
                else flakeSecrets.wg.peers.${n}.endpoint;
              presharedKeyFile = sopsSecrets."wg/peers/${n}/psk".path;
            })
            peersNames;
        };
      };
      firewall = {
        allowedUDPPorts = [flakeSecrets.wg.port];
      };

      # Prevent traffic from leaking to other interfaces
      nftables.tables.wg-leak = lib.mkIf (!cfg.isServer) {
        family = "inet";
        content = ''
          chain output {
            type filter hook output priority 0; policy accept;
            ip daddr { ${config.heim.net.wg.subnet}, ${config.heim.net.services.subnet} } oifname != "wg0" reject
          }
        '';
      };
    };
  };
}
