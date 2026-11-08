{
  dotfileFolder,
  flakes,
  ...
}:

{
  services.copyparty = {
    enable = true;
    user = "fantomitechno";
    group = "users";

    settings = {
      i = "127.0.0.1";
      p = [
        4025
      ];
      xf-host = "files.fantomitechno.dev";
      xf-proto-fb = "https";
      rproxy = -1;
    };

    accounts = {
      fantomitechno = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-fantom";
      };
      parrot = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-parrot";
      };
      editors = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-editors";
      };
    };

    volumes = {
      "/celeste" = {
        path = "/nas/celeste";

        access = {
          r = "*";
          A = [ "fantomitechno" ];
        };

        flags = {
          # scan for new files every 60sec
          scan = 60;
        };
      };
      "/public" = {
        path = "/nas/public";

        access = {
          r = "*";
          A = [ "fantomitechno" ];
        };
      };
      "/private" = {
        path = "/nas/private";

        access = {
          A = [ "fantomitechno" ];
        };
      };
      "/unlisted" = {
        path = "/nas/unlisted";

        access = {
          g = "*";
          A = [ "fantomitechno" ];
        };
      };
      "/parrot-team" = {
        path = "/nas/parrot";

        access = {
          A = [ "fantomitechno" ];
          rwdm = [ "parrot" ];
          rw = [ "editors" ];
        };

        flags = {
          vmaxb = "1t";
          maxn = "100,1800"; # each IP can upload 250 files in 30 minutes
          maxb = "200g,120"; # each IP can upload 2gb over 2 minutes

          du_who = "auth"; # logged in users can see disk space
        };
      };
      "/paperless-import" = {
        path = "/nas/paperless/import";

        access = {
          A = [ "fantomitechno" ];
        };
      };
      "/media" = {
        path = "/nas/media";

        access = {
          A = [ "fantomitechno" ];
        };

        flags = {
          # scan for new files every 60sec
          scan = 60;
        };
      };
    };
  };

  nixpkgs = {
    overlays = [ flakes.inputs.copyparty.overlays.default ];
  };
}
