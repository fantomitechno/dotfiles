{ dotfileFolder, ... }:
{
  services.freeradius = {
    enable = true;
    configDir = "${dotfileFolder}/modules/freeradius/config";
  };
}
