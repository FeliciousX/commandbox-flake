# Nix Flake for Commandbox

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    commandbox = {
      url = "github:FeliciousX/commandbox-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, commandbox }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        box = commandbox.packages.${system}.default.override {
          # defaults to nixpkgs.jdk if not specified
          jdk = pkgs.jdk11_headless;
        };
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          packages = [
            box
          ];
        };
      });
}
```

## TODO:
- [ ] Support windows binary when running on windows
- [ ] Support non-flake


## How to update

Currently updating commandbox version is done manually.

1. Get the commandbox download URL for the latest version from https://commandbox.ortusbooks.com/setup/download
2. Update the url in `flake.nix`
3. Change the sha256 hash to an empty string
4. Run `nix flake update` to update flake.lock file
5. Run `nix shell` to make sure `box` command is available
6. Update sha256 hash from the output
7. Check commandbox version by running `box version`
8. Commit changes and create a PR
