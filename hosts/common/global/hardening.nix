{
  pkgs,
  lib,
  ...
}: {
  security = {
    lockKernelModules = true;
    protectKernelImage = true;
    virtualisation.flushL1DataCache = "always";

    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };

  sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = true;
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

    "kernel.core_pattern" = "|/bin/false";
    "fs.suid_dumpable" = "0";
  };

  systemd.coredump.extraConfig = lib.mkDefault ''
    Storage=none
  '';

  environment.etc = {
    # Empty /etc/securetty to prevent root login on tty.
    securetty.text = ''
      # /etc/securetty: list of terminals on which root is allowed to login.
      # See securetty(5) and login(1).
    '';
  };

  boot.kernelParams = ["debugfs=off"];
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];
}