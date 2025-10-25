{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;

    config = {
      style = "numbers,changes,header";
    };
    extraPackages = builtins.attrValues {
      inherit (pkgs.stable.bat-extras) batdiff batman batgrep;
    };
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    cat = "bat";
    diff = "batdiff";
    rg = "batgrep";
    man = "batman";
  };
}
