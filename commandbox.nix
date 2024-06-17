{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "commandbox";
  version = "6.0.0";
  src = pkgs.fetchzip {
    url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/6.0.0/commandbox-bin-6.0.0.zip";
    sha256 = "4zhjtqb62U2RQZRZbFLFfL1Etykx1Rchosy6Nu+fMiU=";
  };
  meta.mainProgram = "box";

  buildInputs = [
    pkgs.which # box uses which on certain commands on runtime
    pkgs.jdk11_headless # TODO: figure out if user can override this
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv box $out/bin/box
    runHook postInstall
  '';
}
