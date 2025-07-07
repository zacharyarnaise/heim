{
  config,
  inputs,
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
    networkmanager = {
      enable = true;

      plugins = lib.mkForce [];
      dns = "systemd-resolved";
      unmanaged = [
        "interface-name:docker*"
        "interface-name:veth*"
      ];
      wifi.backend = "iwd";

      ensureProfiles = {
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

    wireless.iwd.settings = {
      General = {
        ManagementFrameProtection = 2;
        RoamThreshold = "-75";
        RoamThreshold5G = "-80";
      };
    };
  };

  systemd = {
    services.NetworkManager-wait-online.enable = false;
    network.networks = {
      "25-wireless" = {
        matchConfig.Name = "wl*";
        networkConfig = {
          DHCP = "yes";
          IgnoreCarrierLoss = "10s";
        };
      };
    };
  };
}
