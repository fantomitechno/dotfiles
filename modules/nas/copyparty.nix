{
  dotfileFolder,
  ...
}:
let
  copyparty = fetchTarball {
    url = "https://github.com/9001/copyparty/releases/download/v1.20.16/copyparty-1.20.16.tar.gz";
    sha256 = "04ym88n720svqmp8ffmsymav1mn30s6ikgfnqy42nh11205v22s1";
  };
in
{
  # load the copyparty NixOS module
  imports = [ "${copyparty}/contrib/nixos/modules/copyparty.nix" ];

  # add the copyparty overlay to expose the package to the module
  nixpkgs.overlays = [ (import "${copyparty}/contrib/package/nix/overlay.nix") ];

  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
    settings = {
      i = "127.0.0.1";
      p = [
        3210
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
        path = "/mnt/data/public";

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
}
