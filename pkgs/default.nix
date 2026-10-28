{
  pkgs,
  inputs,
}: {
  custom-gcl = pkgs.callPackage ./custom-gcl {src = inputs.secrets.work.githubWorkflows;};
  nextcloud-deck_daily = pkgs.callPackage ./nextcloud-deck_daily {};
}
