{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options = {
    deviceSpecific = {
      isLaptop = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
