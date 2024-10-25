{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Dependencies that should only exist in the build environment.
    cargo
    rustc
    rustfmt
    clippy
  ];

  buildInputs = [
    # Dependencies that should exist in the runtime environment.
  ];

}
