{
  inputs,
  config,
  lib,
  ...
}: let
  sopsSecrets = config.sops.secrets;
  flakeSecrets = inputs.secrets;
in {
  sops.secrets = {
    "wireless" = {};
  };

  networking = {
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.settings = {
      General.ManagementFrameProtection = 2;
    };

    networkmanager.ensureProfiles = {
      environmentFiles = [sopsSecrets."wireless".path];
      profiles = {
        wf-1 = let
          secretConfig = flakeSecrets.wireless.wf1;
        in {
          connection.id = "wf1";
          connection.type = "wifi";
          wifi.mode = "infrastructure";
          wifi.ssid = "$WF1_SSID";
          ipv4 = {
            ignore-auto-dns = true;
            may-fail = false;
            method = "auto";
          };
          ipv6 = {
            ignore-auto-dns = true;
            method = "auto";
          };
          inherit (secretConfig) wifi-security;
        };
      };
    };
  };

  systemd.network.networks = {
    "25-wireless" = {
      matchConfig.Name = "wl*";
      networkConfig.DHCP = "yes";
      dhcpV4Config.RouteMetric = 1024;
      dhcpV6Config.RouteMetric = 1024;
    };
  };
}
