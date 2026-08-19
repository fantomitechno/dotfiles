{
  dotfileFolder,
  flakes,
  ...
}:

{
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";

    settings = {
      i = "127.0.0.1";
      p = [
        4025
      ];
    };

    accounts = {
      fantomitechno = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-fantom";
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
