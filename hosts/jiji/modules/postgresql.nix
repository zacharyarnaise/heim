{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;

    dataDir = "/storage/data01/postgresql/17";
    settings = {
      log_checkpoints = false;
      shared_buffers = "128MB";
    };
  };
}
