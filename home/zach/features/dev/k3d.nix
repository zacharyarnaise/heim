{pkgs, ...}: let
  # TODO: there must be a better way to do this??
  kubeletImageGc = pkgs.writeText "90-image-gc.conf" ''
    apiVersion: kubelet.config.k8s.io/v1beta1
    kind: KubeletConfiguration
    imageMaximumGCAge: 72h
  '';
in {
  home.packages = [pkgs.k3d];

  # Usage:
  #   k3d registry create --default-network podman registry --image docker.io/library/registry:3
  #   k3d cluster create --config ~/.config/k3d/config.yaml
  # The registry can't be created from the config: it would join the "bridge" network, which podman doesn't allow
  # https://k3d.io/stable/usage/configfile/
  xdg.configFile."k3d/config.yaml".source = (pkgs.formats.yaml {}).generate "k3d-config.yaml" {
    apiVersion = "k3d.io/v1alpha5";
    kind = "Simple";
    metadata.name = "k3s-default";
    volumes = [
      {
        volume = "${kubeletImageGc}:/var/lib/rancher/k3s/agent/etc/kubelet.conf.d/90-image-gc.conf";
        nodeFilters = ["server:*"];
      }
    ];
    registries.use = ["k3d-registry:5000"];
    options = {
      k3d.disableLoadbalancer = true;
      k3s.extraArgs = [
        {
          arg = "--disable=traefik,servicelb,metrics-server";
          nodeFilters = ["server:*"];
        }
        {
          arg = "--kubelet-arg=feature-gates=KubeletInUserNamespace=true";
          nodeFilters = ["server:*"];
        }
      ];
    };
  };

  systemd.user = {
    services."k3d-start" = {
      Unit = {
        Description = "Start the k3d cluster";
        Wants = ["podman.socket"];
        After = ["podman.socket"];
      };
      Service = {
        Environment = [
          # Workaround for error: cannot setup namespace using newuidmap
          # See: https://github.com/NixOS/nixpkgs/issues/138423#issuecomment-947888673
          "PATH=/run/wrappers/bin:/run/current-system/sw/bin"
          "DOCKER_HOST=unix://%t/podman/podman.sock"
          "DOCKER_SOCK=%t/podman/podman.sock"
        ];
        # "-" ignore errors if registry or cluster doesn't exist
        ExecStart = [
          "-/run/current-system/sw/bin/podman start k3d-registry"
          "-${pkgs.k3d}/bin/k3d cluster start k3s-default"
        ];
        Type = "oneshot";
        RemainAfterExit = true;
      };
      Install.WantedBy = ["default.target"];
    };

    # tilt-* images aren't cleaned up automatically
    services."k3d-registry-cleanup" = {
      Unit = {
        Description = "Clean k3d registry";
        Before = ["k3d-start.service"];
      };
      Service = {
        # Workaround for error: cannot setup namespace using newuidmap
        # See: https://github.com/NixOS/nixpkgs/issues/138423#issuecomment-947888673
        Environment = "PATH=/run/wrappers/bin:/run/current-system/sw/bin";
        ExecStart = [
          "/run/current-system/sw/bin/podman start k3d-registry"
          "/run/current-system/sw/bin/podman exec k3d-registry rm -rf /var/lib/registry/docker"
          "/run/current-system/sw/bin/podman restart k3d-registry"
        ];
        Type = "oneshot";
      };
    };
    timers."k3d-registry-cleanup" = {
      Unit.Description = "Clean k3d registry timer";
      Timer = {
        OnCalendar = "Mon,Thu 04:00";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
