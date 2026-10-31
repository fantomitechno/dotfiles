{
  dotfileFolder,
  lib,
  config,
  pkgs,
  ...
}:
let
  stateDir = "/var/lib/forgejo";
  nas = "/nas/forgejo/data";
in
{
  systemd.tmpfiles.rules = [
    "d '${config.services.forgejo.customDir}/public' - forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets' - forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets/img' - forgejo forgejo - -"
    "d '${config.services.forgejo.customDir}/public/assets/css' - forgejo forgejo - -"
    "C+ '${config.services.forgejo.customDir}/public/assets/css/theme-custom.css' - forgejo forgejo - ${./theme-custom.css}"
    "L+ '${config.services.forgejo.customDir}/public/assets/img/logo.svg' - forgejo forgejo - ${./logo.svg}"
    "d ${nas}/repositories     0750 forgejo forgejo - -"
    "d ${nas}/lfs              0750 forgejo forgejo - -"
  ];

  systemd.services.forgejo = {
    serviceConfig.ReadWritePaths = [ "/nas/forgejo/data" ];
    # make sure the NAS is mounted before Forgejo starts
    unitConfig.RequiresMountsFor = [ "/nas/forgejo/data" ];
  };

  services = {
    forgejo = {
      enable = true;
      user = "fantomitechno";
      database.type = "sqlite3";
      lfs.enable = true;

      inherit stateDir;
      repositoryRoot = "${nas}/repositories";
      lfs.contentDir = "${nas}/lfs";

      settings = {
        DEFAULT = {
          APP_NAME = "git.fantomitechno.dev";
        };
        server = {
          DOMAIN = "git.fantomitechno.dev";
          ROOT_URL = "https://git.fantomitechno.dev";
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = 4005;
          SSH_PORT = lib.head config.services.openssh.ports;
        };
        service.DISABLE_REGISTRATION = true;
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };

        mailer = {
          ENABLED = true;
          SMTP_ADDR = "smtp.resend.com";
          SMTP_PORT = "2465";
          FROM = "me@no-reply.fantomitechno.dev";
          USER = "resend";
        };

        "ui.meta" = {
          AUTHOR = "git.fantomitechno.dev";
          DESCRIPTION = "Selfhosted, running Forgejo on NixOS";
          KEYWORDS = "fantomitechno,git,forge,forgejo";
        };
        ui = {
          DEFAULT_THEME = "custom";
          THEMES = "forgejo-auto,forgejo-light,forgejo-dark,custom";
        };
      };
      secrets = {
        mailer.PASSWD = lib.mkForce "${dotfileFolder}/pswd/forgejo-mailer";
      };
    };

    # forgejo-runner = {
    #   package = pkgs.forgejo-runner;
    #   instances.default = {
    #     enable = true;
    #     runtimes.host = true;
    #     settings.runner.labels = [
    #       # Native Execution on the Host
    #       "native:host"

    #       # Assuming Docker has been setup on the host machine
    #       "ubuntu-latest:docker://node:16-bullseye"
    #       "ubuntu-22.04:docker://node:16-bullseye"
    #       "ubuntu-20.04:docker://node:16-bullseye"
    #       "ubuntu-18.04:docker://node:16-buster"
    #     ];
    #     secrets.server.connections."forgejo".token_url = "${dotfileFolder}/pswd/forgejo-runner"; # Path to forgejo runner key file provided by forgejo.
    #     settings.server.connections.forgejo = {
    #       url = "https://git.fantomitechno.dev"; # Forgejo Instance URL
    #       uuid = "387b9b3a-81be-4a51-8f87-abe7381e71a7"; # UUID of forgejo runner instance
    #     };
    #   };
    # };

    openssh = {
      settings.AllowUsers = [ config.services.forgejo.user ];
      settings.AllowGroups = [ config.services.forgejo.group ];
    };

    anubis.instances."forgejo" = {
      settings = {
        BIND = ":4006";
        BIND_NETWORK = "tcp";
        TARGET = "http://127.0.0.1:4005";
      };
    };
  };
}
