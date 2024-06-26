{
  users.users.zach = {
    isNormalUser = true;
    description = "Zach";
    extraGroups = ["wheel"];
    # hashedPasswordFile = config.sops.secrets.layla-password.path;
    # TODO: remove when things are working
    password = "testing";
  };

  # Persist entire home
  environment.persistence."/persist" = {
    directories = ["/home/zach"];
  };
}
