{ pkgs ? import <nixpkgs> {} }:
  pkgs.stdenv.mkDerivation {
    name = "ziglings";
    buildInputs = [
      (pkgs.stdenv.mkDerivation {
        name = "zig-dev";
        src = pkgs.fetchurl {
          url = "https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.1573+4d81e8ee9.tar.xz";
          sha256 = "173jb404w9gv5r4mpxm1kw9s3914almb0xpb28dilbggprqzmzr4";
        };
        installPhase = ''
          mkdir -p $out/bin
          cp -r * $out/bin/
        '';
      })
    ];
  }
