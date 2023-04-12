{
  description = "CommandBox ColdFusion (CFML) CLI, Package Manager, REPL and much more!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          src = pkgs.fetchurl {
            url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/5.8.0/commandbox-bin-5.8.0.zip";
            sha256 = "d6acc9d93cbe72e247f7d1a4e51fe561c918951b555370f882fe312c98c45a69";
          };
          name = "commandbox-5.8.0";
          inherit system;
          dontUnpack = true;
          meta.mainProgram = "box";
          buildInputs = [ pkgs.unzip ];
          buildPhase = ''
            unzip $src
          '';
          installPhase = ''
            mkdir -p $out/bin
            mv box $out/bin/box
          '';
        };
      }
    );
}