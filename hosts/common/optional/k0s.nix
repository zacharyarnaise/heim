{
  inputs,
  pkgs,
  config,
  ...
}: let
  hostname = config.hostSpec.name;
  inherit (inputs.secrets.hosts.${hostname}) inet;
in {
  imports = [inputs.k0s-nix.nixosModules.default];

  services.k0s = {
    enable = true;
    package = inputs.k0s-nix.packages."${pkgs.stdenv.system}".k0s_1_33;

    role = "single";
    dataDir = "/persist/k0s";
    clusterName = "k0s";
    disabledComponents = [
      "metrics-server"
    ];
    spec = {
      api = {
        address = inet;
        sans = [inet];
      };
      telemetry.enabled = false;
    };
  };

  services.dockerRegistry = {
    enable = true;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
    extraConfig = {
      log.level = "warn";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [6443];
  };
}
