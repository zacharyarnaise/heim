{
  inputs,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit (config) hostSpec;
  };
}
