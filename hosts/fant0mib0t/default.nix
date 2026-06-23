{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../server.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  system.stateVersion = "26.05";
}
