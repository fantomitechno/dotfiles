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
          rw = [ "fantomitechno" ];
        };
      };
      "/public" = {
        path = "/nas/public";

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
        path = "/nas/paperless/import";

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
