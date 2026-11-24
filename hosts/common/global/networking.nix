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
      "86.54.11.100#unfiltered.joindns4.eu"
      "86.54.11.200#unfiltered.joindns4.eu"
      "2a13:1001::86:54:11:100#unfiltered.joindns4.eu"
      "2a13:1001::86:54:11:200#unfiltered.joindns4.eu"
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
      FallbackDNS = [];
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
        dhcpV4Config.UseDNS = false;
        dhcpV6Config.UseDNS = false;
        ipv6AcceptRAConfig.UseDNS = false;
      };
    };
  };
}
