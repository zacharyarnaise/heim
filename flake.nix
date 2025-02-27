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

    lib = nixpkgs.lib.extend (_: _: import ./lib {inherit (nixpkgs) lib;});

    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    pkgsFor = lib.genAttrs supportedSystems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = builtins.attrValues (import ./overlays {inherit inputs;});
        }
    );
    forEachSystem = f: lib.genAttrs supportedSystems (sys: f pkgsFor.${sys});

    mkNixos = hostname: system: {
      name = hostname;
      value = lib.nixosSystem {
        specialArgs = {inherit lib inputs outputs;};
        modules = [
          nixpkgs.nixosModules.readOnlyPkgs
          {nixpkgs.pkgs = pkgsFor.${system};}

          ./hosts/${hostname}/spec.nix
          ./hosts/${hostname}
        ];
      };
    };

    mkHome = username: hostname: system: {
      name = "${username}@${hostname}";
      value = lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit lib inputs;
          inherit (import ./hosts/${hostname}/spec.nix) hostSpec;
        };
        pkgs = pkgsFor.${system};
        modules = [./home/${username}/${hostname}.nix];
      };
    };
  in {
    # Custom packages to be shared or upstreamed
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Nix formatter available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # -- NixOS configurations --------------------------------------------------
    nixosConfigurations = lib.listToAttrs [
      (mkNixos "calcifer" "x86_64-linux")
      (mkNixos "howl" "x86_64-linux")
      (mkNixos "laptop-gb" "x86_64-linux")
      (mkNixos "noface" "x86_64-linux")
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
