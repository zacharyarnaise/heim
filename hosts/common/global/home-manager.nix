{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit pkgs inputs outputs;
    hostSpec = config.hostSpec;
  };
}
