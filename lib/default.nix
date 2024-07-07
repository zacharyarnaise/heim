{
  lib,
  inputs,
  ...
}:
lib.makeExtensible (self: let
  callLibs = file:
    import file {
      inherit inputs;
      lib = self;
    };
in {
  dirs = callLibs ./dirs.nix;
})
