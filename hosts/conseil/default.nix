{
  pkgs,
  dotfileFolder,
  flakes,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../server.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  services = {
    nfs.server = {
      enable = true;
      statdPort = 4000;
      lockdPort = 4001;
      mountdPort = 4002;
      # exports = ''
      #
      # '';
    };

    copyparty = {
      enable = true;
      user = "copyparty";
      group = "copyparty";
      settings = {
        i = "172.16.20.10";
        p = [
          3210
          3211
        ];
        no-reload = true;
        ignored-flag = false;
      };

      accounts = {
        fantomitechno = {
          passwordFile = "${dotfileFolder}/hosts/conseil/pswd/copyparty-fantom";
        };
      };

      volumes = {
        "/public" = {
          # path = ""

          access = {
            r = "*";
            rw = [ "fantomitechno" ];
          };

          flags = {
            scan = 60;
          };
        };
      };
    };

    garage = {
      enable = true;

      settings = {
        metadata_dir = "/var/lib/garage/meta";
        data_dir = "/var/lib/garage/data";

        s3_api = {
          api_bind_addr = "[::]:3900";
          s3_region = "garage";
        };

        s3_web = {
          bind_addr = "[::]:3902";
        };
      };
    };
  };

  nixpkgs = {
    overlays = [ flakes.inputs.copyparty.overlays.default ];
  };

  system.stateVersion = "26.05";
}
