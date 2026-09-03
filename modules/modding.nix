{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Celeste modding
    avalonia-ilspy

    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )
    mono
  ];

  environment.sessionVariables = {
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
  };
}
