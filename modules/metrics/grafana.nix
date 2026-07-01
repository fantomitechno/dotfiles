{ ... }:
{
  services = {
    grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = "3000";
          domain = "graph.fantom.home";

          enforce_domain = true;
          enable_gzip = true;
        };
      };

      provision = {
        datasources.settings.datasources = [
          {
            name = "Conseil";
            type = "prometheus";
            url = "http://172.16.20.10:3001";
            editable = false;
          }
          {
            name = "fant0mib0t";
            type = "prometheus";
            url = "http://172.16.20.20:3001";
            editable = false;
          }
        ];
      };
    };

    prometheus = {
      exporters.opnsense = {
        enable = true;
        opnsenseServerAddress = "https://routeur.fantom.home";
        port = 3003;
      };
      scrapeConfigs = [
        {
          job_name = "opnsense";
          static_configs = [
            {
              targets = [ "127.0.0.1:3003" ];
            }
          ];
        }
      ];
    };
  };
}
