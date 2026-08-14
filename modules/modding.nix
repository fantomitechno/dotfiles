{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Celeste modding
    avalonia-ilspy

    dotnet-sdk_8
    dotnet-runtime_8
  ];
}
