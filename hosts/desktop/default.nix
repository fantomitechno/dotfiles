{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../computer.nix
  ]
  ++ builtins.map (i: ../../modules/${i}) ([
    "cli-apps"
    "codium"
    "desktop-apps"
    "fastfetch"
    "git"
    "niri-de"
    "wallpapers"
    "communication.nix"
    "customisation.nix"
    "editing.nix"
    "games.nix"
    "graphene.nix"
    "greeter.nix"
    "jetbrain.nix"
    "network.nix"
    "terminal.nix"
  ]);

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  console.keyMap = "fr";

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  system.stateVersion = "26.05";
}
