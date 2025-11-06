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
    nix-direnv.enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    config = {
      global = {
        disable_stdin = true;
        strict_env = true;
        warn_timeout = 0;
      };
      whitelist.prefix =
        [
          "${config.home.homeDirectory}/Code/Nix/"
          "/persist${config.home.homeDirectory}/Code/Nix/"
        ]
        ++ lib.optionals config.hostSpec.isWork [
          "${config.home.homeDirectory}/Code/Work/"
          "/persist${config.home.homeDirectory}/Code/Work/"
        ];
    };
    silent = true;
  };

  home.file = lib.mkIf config.hostSpec.isWork {
    "${config.home.homeDirectory}/Code/Work/${secrets.work.env.path}".text =
      secrets.work.env.text;
  };
}
