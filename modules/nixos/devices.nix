{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options = {
    isLaptop = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the device is a laptop";
    };
  };
}
