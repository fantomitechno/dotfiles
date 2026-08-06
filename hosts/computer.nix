{ pkgs, hostname, ... }:

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
      "100.116.20.78" = [
        "knot.fantomitechno.dev"
        "irc"
      ];
      "192.168.1.1" = [ "mabbox.bytel.fr" ];
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

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "electron-39.8.10"
        "idea-oss-2025.3.4"
      ];
    };
  };
}
