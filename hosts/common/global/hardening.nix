{
  config,
  lib,
  ...
}: {
  security = {
    protectKernelImage = true;
    virtualisation.flushL1DataCache = "always";

    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
      extraConfig = let
        timeout =
          if config.hostSpec.isLaptop
          then "2"
          else "15";
      in
        lib.mkAfter ''
          Defaults lecture=never
          Defaults timestamp_timeout=${timeout}
        '';
    };
  };

  boot.kernel.sysctl = {
    "dev.tty.ldisc_autoload" = "0";
    "fs.binfmt_misc.status" = "0";
    "fs.protected_fifos" = "2";
    "fs.protected_regular" = "2";
    "fs.protected_hardlinks" = "1";
    "fs.protected_symlinks" = "1";

    "kernel.sysrq" = "0";
    "kernel.dmesg_restrict" = "1";
    "kernel.kptr_restrict" = "2";
    "kernel.yama.ptrace_scope" = "3";
    "kernel.io_uring_disabled" = "2";
    "kernel.perf_event_paranoid" = "3";
    "kernel.unprivileged_bpf_disabled" = "1";
    "net.core.bpf_jit_harden" = "2";

    "net.ipv4.conf.all.accept_redirects" = "0";
    "net.ipv4.conf.default.accept_redirects" = "0";
    "net.ipv4.conf.all.secure_redirects" = "0";
    "net.ipv4.conf.default.secure_redirects" = "0";
    "net.ipv4.conf.all.send_redirects" = "0";
    "net.ipv4.conf.default.send_redirects" = "0";
    "net.ipv6.conf.all.accept_redirects" = "0";
    "net.ipv6.conf.default.accept_redirects" = "0";

    "kernel.core_pattern" = "|/bin/false";
    "fs.suid_dumpable" = "0";
  };

  systemd.coredump.settings.Coredump.Storage = "none";
}
