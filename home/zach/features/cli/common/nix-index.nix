{
  config,
  inputs,
  pkgs,
  ...
}: let
  nix-index-database = import inputs.nix-index-database.outPath {inherit pkgs;};
in {
  programs.nix-index.enable = true;

  home.file."${config.xdg.cacheHome}/nix-index/files".source =
    nix-index-database.nix-index-small-database;
}
