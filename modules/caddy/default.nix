{ hostname, ... }: {
  services.caddy = {
    enable = true;
    configFile = ./${hostname};
    openFirewall = true;

    httpPort = 80;
    httpsPort = 443;
  };
}
