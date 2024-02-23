{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "x86_64-linux"
    ];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });
  in {
    inherit lib;

    # Reusable NixOS and home-manager modules
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays { inherit inputs outputs; };

    # Custom packages available through 'nix build', 'nix shell', etc.
    packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
    # Formatter available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
        calcifer =  lib.nixosSystem {
          modules = [ ./hosts/calcifer ];
          specialArgs = { inherit inputs outputs; };
        };

        laptop-gb = lib.nixosSystem {
          modules = [ ./hosts/laptop-gb ];
          specialArgs = { inherit inputs outputs; };
        };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      "zach@calcifer" = lib.homeManagerConfiguration {
        modules = [ ./home/zach/calcifer.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };

      "zach@laptop-gb" = lib.homeManagerConfiguration {
        modules = [ ./home/zach/laptop-gb.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
