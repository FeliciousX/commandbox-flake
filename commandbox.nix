{ stdenv, fetchzip }:
stdenv.mkDerivation {
  pname = "commandbox";
  version = "6.0.0";
  src = fetchzip {
    url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/6.0.0/commandbox-bin-6.0.0.zip";
    sha256 = "4zhjtqb62U2RQZRZbFLFfL1Etykx1Rchosy6Nu+fMiU=";
  };
  meta.mainProgram = "box";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv box $out/bin/box
    runHook postInstall
  '';
}
