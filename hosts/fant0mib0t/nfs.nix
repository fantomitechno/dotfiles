{ ... }:
{
  fileSystems."/nas" = {
    device = "172.16.20.10:/data";
    fsType = "nfs";
    # options = [
      # "x-systemd.automount"
      # "noauto"
      # "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
    # ];
  };

  boot.supportedFilesystems = [ "nfs" ];
}
