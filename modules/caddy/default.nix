{ hostname, dotfileFolder, ... }: {
  services.caddy = {
    enable = true;
    enableReload = true;
    configFile = "${dotfileFolder}/modules/caddy/${hostname}";
    openFirewall = true;

    httpPort = 80;
    httpsPort = 443;
  };
}
