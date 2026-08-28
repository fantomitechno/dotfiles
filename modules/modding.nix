{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Celeste modding
    avalonia-ilspy

    dotnet-sdk_8
    dotnet-sdk_9
    dotnet-runtime_8
    dotnet-runtime_9
    fna3d
    mono
  ];

  environment.sessionVariables = {
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
  };
}
