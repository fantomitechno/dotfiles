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
        3210
        3211
      ];
      no-reload = true;
      ignored-flag = false;
    };

    accounts = {
      fantomitechno = {
        passwordFile = "${dotfileFolder}/pswd/copyparty-fantom";
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

  nixpkgs = {
    overlays = [ flakes.inputs.copyparty.overlays.default ];
  };
}
