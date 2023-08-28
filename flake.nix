{
  description = "CommandBox ColdFusion (CFML) CLI, Package Manager, REPL and much more!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in
      {
        formatter = pkgs.nixpkgs-fmt;
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "commandbox";
          version = "5.9.1";
          src = pkgs.fetchurl {
            url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/5.9.1/commandbox-bin-5.9.1.zip";
            sha256 = "d0f395dc8a27ff26528a5e6562d2c1b90770380387fe00cce9d3d1387e0ac466";
          };
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
