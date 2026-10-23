{ pkgs, ... }: {
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  users.users.fantomitechno.extraGroups = [ "incus-admin" ];
  networking.firewall.trustedInterfaces = [ "incusbr0" ];

  environment.systemPackages = with pkgs; [
    arduino-cli
  ];
}
