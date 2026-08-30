{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Celeste modding
    avalonia-ilspy

    dotnet-sdk_9
    dotnet-runtime_8
    dotnet-runtime_9
    mono
  ];

  environment.sessionVariables = {
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
  };
}
