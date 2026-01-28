{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    prismlauncher
    rpi-imager
  ];
}