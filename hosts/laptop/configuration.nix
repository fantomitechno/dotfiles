{
  config,
  pkgs,
  globals,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../common/packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = true;
    grub.device = "/dev/nvme0n1";
    grub.minegrub-theme = {
      enable = true;
      splash = "NixOS for the win!";
    };
    grub.useOSProber = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  networking = {
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    hostName = globals.HostName;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

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

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  system.stateVersion = "25.11";
}