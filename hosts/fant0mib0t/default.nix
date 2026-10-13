{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # ./nfs.nix

    ../server.nix
  ]
  ++ builtins.map (i: ../../modules/${i}) ([
    "caddy"
    # "forgejo"
    # "metrix/grafana.nix"
    # "metrix/prometheus.nix"
    # "tangled"
    # "copyparty.nix"
    "docker.nix"
    "ipmi-fan-control.nix"
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
