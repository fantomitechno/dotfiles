{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fluffychat
    vesktop
    signal-desktop
  ];
}
