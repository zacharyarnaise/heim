# Source: https://github.com/EmergentMind/nix-config/blob/dev/modules/common/host-spec.nix
{lib, ...}: let
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

    # Data options that don't dictate configuration settings
    work = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "An attribute set of work-related information if isWork is true";
    };
  };
}
