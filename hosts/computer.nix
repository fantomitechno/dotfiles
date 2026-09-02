{
  pkgs,
  hostname,
  ...
}:

{
  imports = builtins.map (i: ../modules/${i}) ([
    "cli-apps"
    "desktop-apps"
    "fastfetch"
    "git"
    "wallpapers"
    "communication.nix"
    "greeter.nix"
    "terminal.nix"
  ]);

  networking = {
    networkmanager = {
      enable = true;

      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    hosts = {
      "172.16.20.1" = [ "router.fantom.home" ];
      "172.16.20.2" = [ "core.fantom.home" ];
      "172.16.20.3" = [ "leaf.fantom.home" ];

      "172.16.20.10" = [
        "conseil.fantom.home"

        "s3.fantom.home"
      ];

      "172.16.20.20" = [
        "fant0mib0t.fantom.home"

        "graph.fantom.home"
        "pdf.fantom.home"
        "jellyfim.fantom.home"
        "music.fantom.home"
        "torrent.fantom.home"
        "flaresolver.fantom.home"
        "jackett.fantom.home"
        "sonarr.fantom.home"
        "radarr.fantom.home"
        "bazarr.fantom.home"
      ];
    };

    hostName = "fantomitechno-${hostname}";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  users.users."fantomitechno" = {
    extraGroups = [
      "networkmanager"
      "wireshark"
    ];
  };
}
