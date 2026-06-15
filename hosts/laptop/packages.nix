{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Nantarena
    arp-scan
    mongodb-compass
    nmap

    # Raspberry pi
    rpi-imager

    # Editing for Ms. Jay "Parrot" Dash
    kdePackages.kdenlive
    audacity

    framework-tool

    # Internship
    firefox
    teams-for-linux

    # Graphene installation process
    androidenv.androidPkgs.platform-tools
  ];
}
