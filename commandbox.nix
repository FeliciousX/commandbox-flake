{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation {
  pname = "commandbox";
  version = "6.0.0";
  src = pkgs.fetchzip {
    url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/6.0.0/commandbox-bin-6.0.0.zip";
    sha256 = "4zhjtqb62U2RQZRZbFLFfL1Etykx1Rchosy6Nu+fMiU=";
  };
  meta.mainProgram = "box";

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv box $out/bin/box

    wrapProgram $out/bin/box \
    --set JAVA_HOME ${pkgs.jdk.home}
  '';
}
