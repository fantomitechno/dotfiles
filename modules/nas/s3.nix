{ pkgs, ... }: {
  services = {
    garage = {
      enable = true;

      package = pkgs.garage;

      settings = {
        metadata_dir = "/var/lib/garage/meta";
        data_dir = "/var/lib/garage/data";
        rpc_bind_addr = "[::]:3901";
        rpc_bind_outgoing = false;
        rpc_public_addr = "[fc00:1::1]:3901";

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
}
