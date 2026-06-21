{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fractal
    vesktop
    signal-desktop
  ];
}
