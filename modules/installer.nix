{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];
  networking = {
    hostName = "fantomitechn-installer";
    wireless = {
      enable = lib.mkForce false;
      iwd.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    btop
    curl
    dig
    duf
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "26.05";
}
