{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    arp-scan
    prismlauncher
    rpi-imager
  ];
}