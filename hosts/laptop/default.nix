{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../computer.nix
  ]
  ++ builtins.map (i: ../../modules/${i}) ([
    "codium"
    "kde"
    "niri-de"
    "battery-notify.nix"
    "editing.nix"
    "flint.nix"
    "framework.nix"
    "games.nix"
    "graphene.nix"
    "jetbrain.nix"
    "network.nix"
    "nantarena.nix"
    "raspberry.nix"
  ]);

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.fprintd.enable = lib.mkForce false;

  console.keyMap = "us";

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  system.stateVersion = "26.05";
}
