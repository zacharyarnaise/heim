{
  imports = [./all];

  users.users.zach = {
    extraGroups = [
      "vboxsf"
    ];
  };
}
