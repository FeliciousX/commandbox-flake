{
  description = "CommandBox ColdFusion (CFML) CLI, Package Manager, REPL and much more!";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

  outputs = { self, nixpkgs, systems, ... }:
    let eachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      packages = eachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.callPackage ./commandbox.nix { };
        }
      );
      apps = eachSystem (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/box";
        };
      });
    };
}
