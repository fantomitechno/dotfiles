{
  disko.devices = {
    main.device = "/dev/sdx";
    disk = {
      ssd = {
        type = "disk";
        device = "/dev/sdx";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "64M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      hdd1 = {
        type = "disk";
        device = "/dev/sdy";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
      hdd2 = {
        type = "disk";
        device = "/dev/sdz";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
    };

    # To add new drives... for what to put in here, glhf idk
    # https://openzfs.github.io/openzfs-docs/man/master/8/zpool-attach.8.html#Example_2_:_Expanding_a_RAID-Z_vdev_with_an_additional_disk
    zpool = {
      storage = {
        type = "zpool";
        mode = "raidz1";
        mountpoint = "/data";

        datasets = {
          dataset = {
            type = "zfs_fs";
            mountpoint = "/storage/dataset";
          };
        };
      };
    };
  };
}
