{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    arp-scan
    mongodb-compass
    prismlauncher
    rpi-imager
  ];
}