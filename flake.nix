{
  description = "CommandBox ColdFusion (CFML) CLI, Package Manager, REPL and much more!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.callPackage ./commandbox.nix { };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/box";
        };
      }
    );
}
