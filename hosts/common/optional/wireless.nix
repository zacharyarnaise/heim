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
            connection = {
              id = "wf1";
              type = "wifi";
              interface-name = config.hostSpec.wlanInterface;
            };
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
          wf-2 = let
            secretConfig = flakeSecrets.wireless.wf2;
          in {
            connection = {
              id = "wf2";
              type = "wifi";
              interface-name = config.hostSpec.wlanInterface;
            };
            wifi.mode = "infrastructure";
            wifi.ssid = "$WF2_SSID";
            ipv4 = {
              ignore-auto-dns = true;
              may-fail = false;
              method = "auto";
            };
            ipv6 = {
              ignore-auto-dns = true;
              method = "auto";
              never-default = true;
            };
            inherit (secretConfig) wifi-security;
          };
        };
      };
    };

    wireless.iwd.settings = {
      General = {
        ManagementFrameProtection = 2;
        RoamThreshold = "-70";
        RoamThreshold5G = "-80";
      };
    };
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
      # Fix race condition where iwd starts before the network interface is available
      iwd = let
        subsystemDevice = "sys-subsystem-net-devices-${config.hostSpec.wlanInterface}.device";
      in {
        after = [subsystemDevice];
        wants = [subsystemDevice];
      };
    };
    network.networks = {
      "25-wireless" = {
        matchConfig.Name = "wl*";
        networkConfig = {
          DHCP = "yes";
          IgnoreCarrierLoss = "10s";
          IPv6PrivacyExtensions = true;
        };
      };
    };
  };
}
