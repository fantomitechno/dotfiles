{ pkgs, ... }:

{
  networking = {
    nameservers = [
      "9.9.9.9"
    ];
    networkmanager.enable = true;
    hosts = {
      "100.116.20.78" = [ "knot.fantomitechno.dev" ];
      "192.168.1.1" = [ "mabbox.bytel.fr" ];
    };
  };

  hardware.bluetooth.enable = true;

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
    packages = with pkgs; [
      brave
    ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
