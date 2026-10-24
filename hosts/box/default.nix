{
  pkgs,
  lib,
  hostname,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ builtins.map (i: ../../modules/${i}) ([
    "cli-apps"
    "fastfetch"
    "kde-bigscreen"
    "git"
    "wallpapers"
    "network.nix"
    "terminal.nix"
    "ssh.nix"
  ]);

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  services.fprintd.enable = lib.mkForce false;

  console.keyMap = "fr";

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  system.stateVersion = "26.05";

  home-manager.users."fantomitechno" = { lib, ... }: {
    home.stateVersion = "26.05";
  };

  networking = {
    networkmanager.enable = true;
    hostName = "fantomitechno-${hostname}";
  };

  users.users."fantomitechno" = {
    extraGroups = [
      "networkmanager"
      "wireshark"
    ];
  };
}
