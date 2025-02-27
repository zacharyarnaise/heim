{
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager.useGlobalPkgs = false;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
    inherit (config) hostSpec;
  };
}
