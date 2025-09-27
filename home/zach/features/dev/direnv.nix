{
  config,
  lib,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    config = {
      global = {
        disable_stdin = true;
        strict_env = true;
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
}
