{
  description = "dev shell environment for ziglings";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    usershell.url = "github:cwndrws/usershell";
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
  outputs = { self, nixpkgs, flake-utils, usershell, zig-overlay, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          zig-nightly = zig-overlay.packages.${system}.master;
        in
        {
          devShells.default = usershell.lib.mkUserShell {
            inherit pkgs;
            buildInputs = [ zig-nightly ];
          };
        }
      );
}

