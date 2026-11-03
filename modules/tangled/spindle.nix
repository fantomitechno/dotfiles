{ flakes, ... }: {
  imports = [
    flakes.inputs.tangled.nixosModules.spindle
  ];

  services.tangled.spindle = {
    enable = true;
    server = {
      listenAddr = "127.0.0.1:4001";
      hostname = "spindle.fantomitechno.dev";
      owner = "did:plc:q2leouakch2kg4ruldreunip";
    };
    keyPath = "/var/lib/secrets/spindle-key.pem";
    contact.email = "spindle@fantomitechno.dev";
    artifactStores.s3.bucket = "";
    pipelines.workflowTimeout = "10m";
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/spindle/images/nixos - - - - ${flakes.inputs.tangled.packages.x86_64-linux.spindle-nixos-image}"
  ];
}
