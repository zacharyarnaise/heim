{
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
      inherit (config) hostSpec;
    };
  };
}
