{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self, nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default =
      pkgs.stdenv.mkDerivation
      {
        src = pkgs.fetchurl {
          url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/5.8.0/commandbox-jre-linux64-5.8.0.zip";
          sha256 = "22fda3337bc8934c169fecde14d4f7c20ab87c0b562864c429979d12a6601c59";
        };
        name = "commandbox-5.8.0";
        inherit system;
        dontUnpack = true;
        buildInputs = [ pkgs.unzip ];
        buildPhase = ''
          unzip $src
        '';
        installPhase = ''
          mkdir -p $out/bin
          mv box $out/bin/box
          mv jre $out/bin/jre
        '';
      };
  };
}