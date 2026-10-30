{ flakes, ... }:
{
  imports = [
    flakes.inputs.disko.nixosModules.disko
    ./disko-config.nix
  ];

  boot.initrd.supportedFilesystems = {
    zfs = true;
  };
  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
  };

  fileSystems."/data" = {
    device = "storage";
    fsType = "zfs";
    options = [ "nofail" ];
  };
}
