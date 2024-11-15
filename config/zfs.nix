{
  config,
  ...
}: {

  boot.supportedFilesystems = ["zfs"];
  boot.initrd.supportedFilesystems = ["zfs"];
  boot.initrd.kernelModules = ["zfs"];

  boot.zfs.forceImportAll = false;
  boot.zfs.forceImportRoot = true;
  boot.zfs.allowHibernation = !config.boot.zfs.forceImportRoot;
  #boot.zfs.extraPools = [];

  services.zfs.autoSnapshot.enable = false;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
}
