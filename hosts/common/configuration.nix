{ globals, pkgs, ... } :

{
  networking = {
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];
    hostName = globals.HostName;
    networkmanager.enable = true;
    hosts = {
      "100.116.20.78" = [ "knot.fantomitechno.dev" ];
    };
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";


  users.users.${globals.UserName} = {
    isNormalUser = true;
    description = "Simon Renoux";
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "docker"
    ];
    packages = with pkgs; [
      brave
    ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;
  virtualisation.docker.enable = true;


  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}