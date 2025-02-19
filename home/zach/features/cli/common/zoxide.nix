{config, ...}: {
  programs.zoxide.enable = true;

  home.sessionVariables = {
    _ZO_DATA_DIR = "/persist${config.home.homeDirectory}/.zoxide.db";
  };
}
