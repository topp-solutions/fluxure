{
  description = "A flow-based data processing framework";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.callPackage (import ./default.nix) { };
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell rec {
            nativeBuildInputs = with pkgs; [
              # Dependencies that should only exist in the build environment.
              cargo
              rust-analyzer
              rustc
              llvmPackages.bintools # lld linker (needed for trunk)
              rustfmt
              clippy

              cargo-deny
              cargo-watch
              cargo-flamegraph
              cargo-nextest

              just # Command runner
              act # Run GitHub actions locally
              trunk # WASM
            ];

            buildInputs = with pkgs; [
              # Dependencies that should exist in the runtime environment.

              # misc. libraries
              openssl
              pkg-config

              # GUI libs
              libxkbcommon
              libGL
              fontconfig
              libGLU # OpenGL
              vulkan-loader # Vulkan

              # wayland libraries
              wayland

              # x11 libraries
              xorg.libXcursor
              xorg.libXi
              xorg.libXrandr
              xorg.libX11
            ];

            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
          };
        }
      );
    };
}
