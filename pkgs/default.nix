{
  pkgs,
  inputs,
}: {
  custom-gcl = pkgs.callPackage ./custom-gcl {src = inputs.secrets.work.githubWorkflows;};
  music-import = pkgs.callPackage ./music-import {};
  nextcloud-deck_daily = pkgs.callPackage ./nextcloud-deck_daily {};
}
