{
  networking = {
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
    network.wait-online.enable = false;
    services.NetworkManager-wait-online.enable = false;
  };
}
