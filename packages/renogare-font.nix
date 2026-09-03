{ pkgs, fetchurl }:

pkgs.stdenv.mkDerivation {
  pname = "renogare";
  version = "1.0";

  src = fetchurl {
    url = "https://dl.dafont.com/dl/?f=renogare";
    hash = "sha256-ZfEaStBFDt13pOBltfcFTyf90e4LomO6mUnrvLinS2A=";
  };

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 Renogare-Regular.otf -t $out/share/fonts

    runHook postInstall
  '';
}
