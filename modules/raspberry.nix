{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Raspberry pi
    rpi-imager
  ];
}
