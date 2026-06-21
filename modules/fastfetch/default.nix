{
  ...
}:
{
  home-manager.users."fantomitechno" =
    {
      config,
      pkgs,
      dotfileFolder,
      ...
    }:
    {
      home.packages = with pkgs; [ fastfetch ];

      xdg.configFile."fastfetch".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/fastfetch/config";
    };
}
