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
      theme = "base16";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
    ];
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
    cat = "bat";
    diff = "batdiff";
    rg = "batgrep";
    man = "batman";
  };
}
