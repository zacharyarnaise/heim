{
  services.k3s = {
    enable = true;

    extraFlags = [
      "--disable-cloud-controller"
      "--disable=servicelb"
      "--disable=local-storage"
      "--disable=metrics-server"
      "--disable=traefik"

      "--etcd-disable-snapshots"

      "--data-dir=/persist/k3s"
    ];
  };

  services.dockerRegistry = {
    enable = true;
    enableDelete = true;
    enableGarbageCollect = true;
    garbageCollectDates = "daily";
  };
}
