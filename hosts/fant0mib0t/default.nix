{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nfs.nix

    ../server.nix
  ]
  ++ builtins.map (i: ../../modules/${i}) ([
    "caddy"
    "radius"
    "tangled"
    "matrix.nix"
  ]);

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  system.stateVersion = "26.05";
  home-manager.users."fantomitechno" = { lib, ... }: {
    home.stateVersion = "26.05";
  };
}
