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
      global = {
        disable_stdin = true;
        strict_env = true;
      };
      whitelist.prefix = lib.mkIf config.hostSpec.isWork [
        "/persist${config.home.homeDirectory}/Code/Work/"
      ];
    };
    silent = true;
  };

  home.file = lib.mkIf config.hostSpec.isWork {
    "/persist/${config.home.homeDirectory}/Code/Work/${secrets.work.env.path}".text =
      secrets.work.env.text;
  };
}
