{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) secrets;
in {
  programs.direnv = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    config = {
      global.strict_env = true;
      whitelist.prefix = lib.mkIf config.hostSpec.isWork [
        "${config.home.homeDirectory}/Code/Work/"
      ];
    };
  };

  home.file = lib.mkIf config.hostSpec.isWork {
    "${config.home.homeDirectory}/Code/Work/${secrets.work.env.path}".text =
      secrets.work.env.text;
  };
}
