{writers}: (writers.writePython3Bin "music-import" {
  flakeIgnore = ["E501"];
} (builtins.readFile ./music_import.py))
