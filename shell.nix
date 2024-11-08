{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Dependencies that should only exist in the build environment.
    cargo
    rust-analyzer
    rustc
    rustfmt
    clippy

    act
    cargo-deny
  ];

  buildInputs = [
    # Dependencies that should exist in the runtime environment.
  ];

}
