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

    nameservers = [
      "9.9.9.11#dns11.quad9.net"
      "149.112.112.11#dns11.quad9.net"
      "2620:fe::11#dns11.quad9.net"
      "2620:fe::fe:11#dns11.quad9.net"
    ];

    networkmanager = {
      enable = true;
      plugins = lib.mkForce [];
      dns = "systemd-resolved";
      unmanaged = [
        "interface-name:docker*"
        "interface-name:veth*"
      ];
    };
  };

  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "true";
    fallbackDns = [
      "127.0.0.1"
      "::1"
    ];
    llmnr = "false";
    extraConfig = ''
      MulticastDNS=no
      Cache=yes
      ReadEtcHosts=yes
      ResolveUnicastSingleLabel=no
    '';
  };

  systemd = {
    services.NetworkManager-wait-online.enable = false;
    network = {
      wait-online.enable = false;
      networks = {
        "20-wired" = {
          matchConfig.Name = "en* | eth*";
          networkConfig.DHCP = "yes";
          # Prefer wired connections
          dhcpV4Config.RouteMetric = 2048;
          dhcpV6Config.RouteMetric = 2048;
        };
      };
    };
  };
}
