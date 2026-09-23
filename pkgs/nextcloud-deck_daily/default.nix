{
  python3Packages,
  writers,
}: (writers.writePython3Bin "nextcloud-deck_daily" {
  libraries = with python3Packages; [holidays requests];
  flakeIgnore = ["E501"];
} (builtins.readFile ./nextcloud_deck_daily.py))
