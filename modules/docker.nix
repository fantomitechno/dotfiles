{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    podman-tui # status of containers in the terminal
    podman-compose
  ];

  # Enable Podman in configuration.nix
  virtualisation.podman = {
    enable = true;
    # Create the default bridge network for podman
    defaultNetwork.settings.dns_enabled = true;
    dockerCompat = true; # Create a `docker` alias for podman
    dockerSocket.enable = true;
  };
  # Keep your user manager running after logout and start it at boot
  users.users.fantomitechno.linger = true;

  # Restart containers that have a restart policy after boot
  systemd.user.services.podman-restart = {
    wantedBy = [ "default.target" ];
  };

  virtualisation.containers.containersConf.settings.engine.compose_warning_logs = false;

  home-manager.users."fantomitechno" =
    {
      ...
    }:
    {
      programs = {
        zsh = {
          oh-my-zsh = {
            plugins = [
              "podman"
              "docker"
              "docker-compose"
            ];
          };
        };
      };
    };
}
