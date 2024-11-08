{ rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "fluxure";
  version = "0.0.2";

  src = ./.;
  cargoLock.lockFile = ./Cargo.lock;
}
