{
  hostname,
  ...
}:
{
  services.prometheus = {
    exporters.node = {
      enable = true;
      port = 3002;
      enabledCollectors = [
        "cpu"
        "diskstats"
        "ethtool"
        "filesystem"
        "softirqs"
        "systemd"
        "tcpstat"
      ];
      extraFlags = [
        "--collector.ntp.protocol-version=4"
        "--no-collector.mdadm"
      ];
    };

    enable = true;
    port = 3001;
    listenAddress = "0.0.0.0";

    scrapeConfigs = [
      {
        job_name = hostname;
        static_configs = [
          {
            targets = [ "127.0.0.1:3002" ];
          }
        ];
      }
    ];
  };
}
