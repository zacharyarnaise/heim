{lib, ...}: {
  services.gnome = {
    gnome-keyring.enable = true;
    gcr-ssh-agent.enable = lib.mkForce false;
  };
  security.pam.services = {
    hyprlock.enableGnomeKeyring = true;
    ly.enableGnomeKeyring = true;
  };
}
