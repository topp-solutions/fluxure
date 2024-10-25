{ rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "fluxure";
  version = "0.0.1";

  src = ./.;
  cargoLock.lockFile = ./Cargo.lock;
}
