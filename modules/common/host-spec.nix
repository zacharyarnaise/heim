# Source: https://github.com/EmergentMind/nix-config/blob/dev/modules/common/host-spec.nix
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.hostSpec = {
    # Configurable options
    isLaptop = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the host is a laptop";
    };
    isWork = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the host is used for work";
    };

    # Data options that don't dictate configuration settings
    work = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "An attribute set of work-related information if isWork is true";
    };
  };
}
