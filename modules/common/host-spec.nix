# Attribute set defining host specifications
# Based on https://github.com/EmergentMind/nix-config/blob/3ae368c/modules/hosts/common/host-spec.nix
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.hostSpec = {
    # General options
    name = mkOption {
      type = types.str;
      description = "The name of the host";
    };
    kind = mkOption {
      type = types.enum ["desktop" "laptop" "headless"];
      description = "The kind of host";
    };
    isWork = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the host is used for work";
    };

    # Auto-derived options
    isDesktop = mkOption {
      type = types.bool;
      default = config.hostSpec.kind == "desktop";
      description = "Whether the host is a desktop";
      readOnly = true;
    };
    isLaptop = mkOption {
      type = types.bool;
      default = config.hostSpec.kind == "laptop";
      description = "Whether the host is a laptop";
      readOnly = true;
    };
    isHeadless = mkOption {
      type = types.bool;
      default = config.hostSpec.kind == "headless";
      description = "Whether the host is headless";
      readOnly = true;
    };

    # Keyboard options
    kbdModel = mkOption {
      type = types.str;
      description = "Keyboard model";
      default = "pc105";
    };
    kbdLayout = mkOption {
      type = types.str;
      description = "Keyboard layout";
      default = "us";
    };
    kbdVariant = mkOption {
      type = types.str;
      description = "Keyboard variant";
      default = "";
    };

    # Hardware related options
    cpuThermalZone = mkOption {
      type = types.nullOr types.int;
      description = "Thermal zone to use for CPU temp monitoring";
      default = null;
    };
    hasDiscreteGPU = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the host has a discrete GPU";
    };
    hasSwap = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the host has swap space configured";
    };
    wlanInterface = mkOption {
      type = types.nullOr types.str;
      description = "The name of the wireless LAN interface, if applicable";
      default = null;
    };

    # Data options that don't dictate configuration settings
    work = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "An attribute set of work-related information if isWork is true";
    };
  };
}
