{
  imports = [
    ./rtorrent.nix
  ];

  users.groups.media = {};

  systemd.tmpfiles.rules = [
    "d /storage/media 0770 root media - -"
  ];
}
