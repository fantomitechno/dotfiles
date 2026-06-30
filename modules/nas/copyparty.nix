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
      i = "172.16.20.10";
      p = [
        4020
      ];
    };

    accounts = {
      fantomitechno = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-fantom";
      };
    };

    volumes = {
      "/public" = {
        path = "/data/public";

        access = {
          r = "*";
          rw = [ "fantomitechno" ];
        };

        flags = {
          # scan for new files every 60sec
          scan = 60;
        };
      };
      "/paperless" = {
        path = "/data/paperless/import";

        access = {
          rw = [ "fantomitechno" ];
        };
      };
    };
  };

  nixpkgs = {
    overlays = [ flakes.inputs.copyparty.overlays.default ];
  };
}
