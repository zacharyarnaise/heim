{
  networking.networkmanager.dns = "systemd-resolved";

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
      CacheFromLocalhost=no
      ReadEtcHosts=yes
      ResolveUnicastSingleLabel=no
    '';
  };
}
