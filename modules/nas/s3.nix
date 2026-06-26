{ ... }: {
  services.garage = {
    enable = true;

    settings = {
      metadata_dir = "/var/lib/garage/meta";
      data_dir = "/var/lib/garage/data";

      s3_api = {
        api_bind_addr = "[::]:3900";
        s3_region = "garage";
      };

      s3_web = {
        bind_addr = "[::]:3902";
      };
    };
  };
}
