{
  config,
  lib,
  ...
}: {
  boot.kernel.sysctl = {
    # Avoid disconnects on long-running connections (e.g. some ssh sessions)
    "net.ipv4.tcp_keepalive_time" = 120;
  };

  networking = {
    hostName = config.hostSpec.name;
    useDHCP = false;
    useNetworkd = true;
    usePredictableInterfaceNames = true;
    nftables = {
      enable = true;
      checkRuleset = true;
    };

    nameservers = [
      "9.9.9.11#dns11.quad9.net"
      "149.112.112.11#dns11.quad9.net"
      "2620:fe::11#dns11.quad9.net"
      "2620:fe::fe:11#dns11.quad9.net"
    ];

    firewall = {
      enable = true;
      logRefusedConnections = false;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      Cache = true;
      DNSOverTLS = true;
      DNSSEC = true;
      FallbackDNS = [
        "127.0.0.1"
        "::1"
      ];
      LLMNR = false;
      MulticastDNS = false;
      ReadEtcHosts = true;
      ResolveUnicastSingleLabel = false;
    };
  };

  systemd.network = {
    wait-online.enable = lib.mkDefault false;
    networks = {
      "20-wired" = {
        matchConfig.Name = "en* | eth*";
        networkConfig = {
          DHCP = "yes";
          IPv6PrivacyExtensions = true;
        };
      };
    };
  };
}
