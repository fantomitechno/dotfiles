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
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = true;
    grub.device = "/dev/nvme0n1";
    grub.minegrub-theme = {
      enable = true;
      splash = "100% NixOS";
      background = "background_options/1.18 - [Caves And Cliffs 2].png";
    };
    grub.useOSProber = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  system.stateVersion = "25.11";
}
