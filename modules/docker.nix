{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

  virtualisation.docker = {
    enable = true;
  };

  home-manager.users."fantomitechno" =
    {
      ...
    }:
    {
      programs = {
        zsh = {
          oh-my-zsh = {
            plugins = [
              "docker"
              "docker-compose"
            ];
          };
        };
      };
    };
}
