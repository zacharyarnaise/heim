{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption;

  monitorOption = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        example = "eDP-1";
      };
      primary = mkOption {
        type = types.bool;
        default = false;
      };
      width = mkOption {
        type = types.int;
        example = 1920;
      };
      height = mkOption {
        type = types.int;
        example = 1080;
      };
      refreshRate = mkOption {
        type = types.int;
        default = 60;
      };
      position = mkOption {
        type = types.str;
        default = "auto";
      };
      scale = mkOption {
        type = types.str;
        default = "auto";
      };
      enabled = mkOption {
        type = types.bool;
        default = true;
      };
      workspace = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      extraArgs = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in {
  options.monitors = mkOption {
    type = types.listOf monitorOption;
    default = [];
  };

  options.primaryMonitor = mkOption {
    type = types.nullOr monitorOption;
    readOnly = true;
    default = lib.head (lib.filter (m: m.primary) config.monitors);
  };

  config = {
    assertions = [
      {
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
