{ pkgs, ... }:

{
  networking = {
    nameservers = [
      "9.9.9.9"
    ];
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
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users."fantomitechno" = {
    isNormalUser = true;
    description = "Simon Renoux";
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
