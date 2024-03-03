{
  inputs,
  outputs,
  ...
}: {
  imports =
    [inputs.home-manager.nixosModules.home-manager]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  nixpkgs.overlays = builtins.attrValues outputs.overlays;
}
