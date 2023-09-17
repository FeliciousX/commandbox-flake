{
  description = "CommandBox ColdFusion (CFML) CLI, Package Manager, REPL and much more!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = import ./commandbox.nix {
          stdenv = pkgs.stdenv;
          fetchzip = pkgs.fetchzip;
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/box";
        };
      }
    );
}
