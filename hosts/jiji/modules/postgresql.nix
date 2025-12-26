{
  config,
  pkgs,
  ...
}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;

    dataDir = "/storage/data01/postgresql/${config.services.postgresql.package.psqlSchema}";
    settings = {
      effective_cache_size = "1GB";
      effective_io_concurrency = 100;
      huge_pages = "off";
      log_checkpoints = false;
      log_min_messages = "error";
      maintenance_work_mem = "64MB";
      shared_buffers = "256MB";
      work_mem = "8MB";
    };
  };
}
