{
  disko = {
    # main.device = "/dev/disk/by-id/ata-PNY_250GB_SATA_SSD_PNB14260008500201622";
    devices = {
      disk = {
        ssd = {
          type = "disk";
          device = "/dev/disk/by-id/ata-PNY_250GB_SATA_SSD_PNB14260008500201622";
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
          device = "/dev/disk/by-id/ata-WDC_WUH721816ALE600_2PGZ8LGT";
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
          device = "/dev/disk/by-id/ata-WDC_WUH721816ALE600_2PH0LMVT";
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

          # datasets = {
          #   dataset = {
          #     type = "zfs_fs";
          #     mountpoint = "/storage/dataset";
          #   };
          # };
        };
      };
    };
  };
}
