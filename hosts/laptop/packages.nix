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

    # Editing for Ms. Jay "Parrot" Dash
    kdePackages.kdenlive

    framework-tool

    eduvpn-client

    # Internship
    firefox
    teams-for-linux
  ];
}
