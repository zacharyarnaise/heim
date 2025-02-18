{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options = {
    device = {
      isLaptop = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the device is a laptop";
      };
    };
  };
}
