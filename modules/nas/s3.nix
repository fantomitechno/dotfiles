{ pkgs, lib, ... }: {
  services = {
    garage = {
      enable = true;

      package = pkgs.garage;

      settings = {
        metadata_dir = "/var/lib/garage/meta";
        data_dir = "/data/garage/data";

        db_engine = "sqlite";
        replication_factor = 1;
        consistency_mode = "consistent";

        rpc_bind_addr = "127.0.0.1:3901";
        rpc_public_addr = "127.0.0.1:3901";
        rpc_secret = "751a05fe57daa1059e8c72304fbd6755f30474a01ec68a58328d075fb8514fba";

        s3_api = {
          api_bind_addr = "127.0.0.1:4010";
          s3_region = "garage";
          root_domain = ".s3.fantom.internal";
        };

        s3_web = {
          bind_addr = "127.0.0.1:4011";
          root_domain = ".s3.fantom.home";
        };
      };
    };
  };

  users.users.garage = {
    isSystemUser = true;
    group = "garage";
  };
  users.groups.garage = { };

  systemd.services.garage.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "garage";
    Group = "garage";
  };

  systemd.tmpfiles.rules = [
    "d /data/garage/data 0750 garage garage -"
  ];
}
