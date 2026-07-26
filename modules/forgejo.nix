{
  dotfileFolder,
  lib,
  config,
  pkgs,
  ...
}:
{
  services = {
    forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.fantomitechno.dev";
          ROOT_URL = "https://git.fantomitechno.dev";
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = 4005;
          APP_DATA_PATH = "/nas/gitea/data";
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
      };
      secrets = {
        mailer.PASSWD = "${dotfileFolder}/pswd/forgejo-mailer";
        security.SECRET_KEY = "${dotfileFolder}/pswd/forgejo-security/secret-key";
        security.INTERNAL_TOKEN = "${dotfileFolder}/pswd/forgejo-security/internal-token";
      };
    };

    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances.default = {
        enable = true;
        name = "monolith";
        url = "https://git.fantomitechno.dev";
        tokenFile = "${dotfileFolder}/pswd/forgejo-runner";
        labels = [
          "ubuntu-latest:docker://node:16-bullseye"
          "ubuntu-22.04:docker://node:16-bullseye"
          "ubuntu-20.04:docker://node:16-bullseye"
          "ubuntu-18.04:docker://node:16-buster"
          ## optionally provide native execution on the host:
          # "native:host"
        ];
      };
    };

    openssh = {
      settings.AllowUsers = [ "git" ];
      settings.AllowGroups = [ "git" ];
    };

    anubis.instances."forgejo" = {
      settings = {
        BIND = "127.0.0.1:4006";
        TARGET = "http://127.0.0.1:4005";
      };
    };
  };
}
