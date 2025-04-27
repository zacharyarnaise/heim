# Source: https://github.com/EmergentMind/nix-config/blob/dev/modules/common/host-spec.nix
{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.hostSpec = {
    # Configurable options
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
    keyboard = mkOption {
      type = types.nullOr types.submodule {
        options = {
          model = mkOption {
            type = types.str;
            default = "pc105";
            description = "The keyboard model";
          };
          layout = mkOption {
            type = types.str;
            default = "us";
            description = "The keyboard layout";
          };
          variant = mkOption {
            type = types.str;
            default = "";
            description = "The keyboard variant";
          };
        };
      };
      default = false;
      description = "The keyboard configuration";
    };

    # Data options that don't dictate configuration settings
    work = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "An attribute set of work-related information if isWork is true";
    };
  };
}
