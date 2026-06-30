{ ... }: {
  services.matrix-conduit = {
    enable = true;

    settings = {
      global = {
        allow_registration = false;
        allow_federation = true;

        database_backend = "rocksdb";

        server_name = "matrix.fantomitechno.dev";
        trusted_servers = [
          "matrix.org"
          "faimaison.net"
        ];

        address = "127.0.0.1";
        port = 2000;
      };
    };
  };
}
