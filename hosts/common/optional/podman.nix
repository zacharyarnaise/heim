{
  config,
  lib,
  ...
}: let
  rootlessPath = "/persist/containers-rootless";
  normalUsers = lib.filterAttrs (_: v: v.isNormalUser) config.users.users;
in {
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      extraRuntimes = lib.mkForce [];

      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = ["--all" "--build" "--volumes"];
      };

      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    containers = {
      storage.settings = {
        storage = {
          driver = "overlay";
          graphroot = "/persist/containers/storage";
          runroot = "/run/containers/storage";
          rootless_storage_path = "${rootlessPath}/$USER";
          options = {
            pull_options = {
              enable_partial_images = "true";
              use_hard_links = "false";
            };
            overlay = {
              force_mask = "0000";
              mountopt = builtins.concatStringsSep "," ["nodev" "metacopy=on"];
            };
          };
        };
      };
      containersConf.settings = {
        containers = {
          log_driver = "k8s-file";
          log_size_max = 104857600; # 100 MiB
        };
        engine = {
          compose_warning_logs = false;
          events_logger = "none";
          healthcheck_events = false;
          image_volume_mode = "tmpfs";
          runtime = "crun";
        };
      };
    };
  };

  environment.extraInit = ''
    if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
      export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
      export DOCKER_BUILDKIT=0
    fi
  '';

  # https://github.com/nikstur/userborn/issues/7#issuecomment-2462106017
  environment.etc = let
    autosubs = lib.pipe normalUsers [
      lib.attrValues
      (lib.concatMapStrings (u: "${toString u.uid}:${toString (100000 + u.uid * 65536)}:65536\n"))
    ];
  in {
    "subuid".text = autosubs;
    "subuid".mode = "0444";
    "subgid".text = autosubs;
    "subgid".mode = "0444";
  };

  # https://github.com/containers/podman/blob/main/troubleshooting.md#26-running-containers-with-resource-limits-fails-with-a-permissions-error
  systemd.services."user@".serviceConfig = {
    Delegate = "cpu cpuset io memory pids";
  };

  systemd.tmpfiles.rules =
    lib.mapAttrsToList (name: _: "d ${rootlessPath}/${name} 0770 ${name} ${name} - -")
    normalUsers;
}
