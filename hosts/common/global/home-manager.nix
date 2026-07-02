{
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    backupFileExtension = "hm-backup";
    overwriteBackup = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
      inherit (config) hostSpec;
    };
  };
}
