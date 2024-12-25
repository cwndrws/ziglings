{
  # Flake dependencies
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig.url = "github:mitchellh/zig-overlay";
  };

  # Flake actions/outputs
  outputs = { flake-utils, nixpkgs, zig, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          zig.overlays.default
        ];
      };
    in with pkgs; {
      devShells.default = mkShell {
        buildInputs = [ zigpkgs.master ];
        shellHook = ''
          # Change bash shell prompt
          export PS1="\w "
        '';
      };
    }
  );
}
