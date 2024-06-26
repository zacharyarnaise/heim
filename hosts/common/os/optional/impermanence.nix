{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence."/persist" = {
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  # Prevent sudo lecture at each reboot
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  # Persist home directories
  system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist/${user.home}
        chown ${user.name}:${user.group} /persist/${user.home}
        chmod ${user.homeMode} /persist/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);
}
