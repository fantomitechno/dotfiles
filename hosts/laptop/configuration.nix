{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.framework.laptop13.audioEnhancement.enable = true;
  services.fprintd.enable = lib.mkForce false;

  networking.hostName = "fantomitechno-laptop";

  console.keyMap = "us";

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  system.stateVersion = "26.05";
}
