{ pkgs, ... }: {
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  users.users.fantomitechno.extraGroups = [ "incus-admin" ];
}
