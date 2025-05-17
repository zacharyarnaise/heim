{
  config,
  lib,
  ...
}: {
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
}
