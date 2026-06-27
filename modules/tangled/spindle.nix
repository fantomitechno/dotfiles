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
    pipelines.workflowTimeout = "10m";
  };
}
