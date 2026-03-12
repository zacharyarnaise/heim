{
  environment.persistence."/persist" = {
    directories = ["/var/cache/powertop"];
  };

  powerManagement.powertop.enable = true;
}
