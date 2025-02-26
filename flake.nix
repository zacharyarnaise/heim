{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Inputs used by all configurations
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      type = "git";
      url = "git+ssh://git@github.com/zacharyarnaise/heim-secrets.git";
      flake = true;
      ref = "main";
      shallow = true;
    };

    # Desktop specific inputs
    stylix.url = "github:danth/stylix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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

    # nixpkgs.lib.extend (l: _: {extras = import ./lib.nix;}) // home-manager.lib;
    lib = nixpkgs.lib // home-manager.lib;

    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forEachSystem = f: lib.genAttrs supportedSystems (sys: f pkgsFor.${sys});
    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );

    mkNixos = hostname: {
      name = hostname;
      value = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/${hostname}/spec.nix
          ./hosts/${hostname}
        ];
      };
    };

    mkHome = username: hostname: system: {
      name = "${username}@${hostname}";
      value = lib.homeManagerConfiguration {
        specialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.${system};
        modules = [
          ./home/nixpkgs.nix
          ./hosts/${hostname}/spec.nix
          ./home/${username}/${hostname}.nix
        ];
      };
    };
  in {
    inherit lib;

    # Reusable custom modules for NixOS and home-manager
    nixosModules = (import ./modules/nixos) // (import ./modules/common);
    homeManagerModules = (import ./modules/home-manager) // (import ./modules/common);
    # Custom modifications/override to upstream packages
    overlays = import ./overlays {inherit inputs outputs;};
    # Custom packages to be shared or upstreamed
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Nix formatter available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # -- NixOS configurations --------------------------------------------------
    nixosConfigurations = lib.listToAttrs [
      (mkNixos "calcifer")
      (mkNixos "howl")
      (mkNixos "laptop-gb")
      (mkNixos "noface")
    ];

    # -- home-manager configurations -------------------------------------------
    homeConfigurations = lib.listToAttrs [
      (mkHome "zach" "calcifer" "x86_64-linux")
      (mkHome "zach" "howl" "x86_64-linux")
      (mkHome "zach" "laptop-gb" "x86_64-linux")
      (mkHome "zach" "noface" "x86_64-linux")
    ];
  };
}
