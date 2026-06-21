{ ... }:
{
  home-manager.users."fantomitechno" =
    {
      pkgs,
      config,
      dotfileFolder,
      ...
    }:
    {
      home.packages = with pkgs; [
        git
        gitmoji-cli
        lazygit
      ];

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Simon R. - fantomitechno";
            email = "me@fantomitechno.dev";
          };
          init.defaultBranch = "main";
          pull.rebase = true;
          color.ui = "auto";
          push.autoSetupRemote = true;
        };

        includes = [
          # hasconfig:remote.*.url:git@...
          {
            condition = "gitdir:${config.home.homeDirectory}/Flint/**";
            contents = {
              user = {
                name = "Simon Renoux";
                email = "simon.renoux@flint.si";
              };
            };
          }
          {
            condition = "gitdir:${config.home.homeDirectory}/Developpement/Polytech*/**";
            contents = {
              user = {
                name = "Simon Renoux";
                email = "simon.renoux@etu.univ-nantes.fr";
              };
            };
          }
        ];
      };

      xdg.configFile."gitmoji-nodejs/config.json".source =
        config.lib.file.mkOutOfStoreSymlink "${dotfileFolder}/modules/git/gitmoji.json";
    };
}
