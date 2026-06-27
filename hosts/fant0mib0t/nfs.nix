{ ... }:
{
  fileSystems."/nas" = {
    device = "172.16.20.10:/data";
    fsType = "nfs";
  };

  boot.supportedFilesystems = [ "nfs" ];
}
