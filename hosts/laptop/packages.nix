{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    arp-scan
    mongodb-compass

    # Games
    prismlauncher

    # Raspberry pi
    rpi-imager

    kdePackages.kdenlive

    eduvpn-client

    # Internship
    firefox
    teams-for-linux
  ];
}
