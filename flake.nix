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
          version = "6.0.0";
          src = pkgs.fetchurl {
            url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/6.0.0/commandbox-bin-6.0.0.zip";
            sha256 = "";
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
