{ pkgs, ... }: {
  services.garage = {
    enable = true;

    package = pkgs.garage;

    settings = {
      metadata_dir = "/var/lib/garage/meta";
      data_dir = "/var/lib/garage/data";

      s3_api = {
        api_bind_addr = "127.0.0.1:3900";
        s3_region = "garage";
      };

      s3_web = {
        bind_addr = "127.0.0.1:3902";
      };
    };
  };
}
