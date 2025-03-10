{ pkgs ? import <nixpkgs> {}, ... }:
let
  version = "0.28.1";

  system = builtins.currentSystem;

  archs = {
    "aarch64-darwin" = "macos-aarch64";
    "x86_64-darwin" = "macos-amd64";
    "aarch64-linux" = "linux-aarch64";
    "x86_64-linux" = "linux-amd64";
  };

  shas = {
    "aarch64-darwin" = "sha256-05Pe2qcGfrXJb/mciec/RjqW9ktOIxv+7kK5hUexD+A=";
    "x86_64-darwin" = "sha256-Wwm9YQ2uUxelLtDDSljNhouxNAqxuVVjWdGsI3PRslQ=";
    "aarch64-linux" = "sha256-INdMCe8EUgAR/7rCLlZ3eKssrgkq+qkmnubvKRPiDwY=";
    "x86_64-linux" = "sha256-/edD7Spf2hzCTOLJkC6g0bxekRot94R8dKd84TBWvzk=";
  };

  arch = archs."${system}";
  sha = shas."${system}";

  url = "https://github.com/apple/pkl/releases/download/${version}/pkl-${arch}";
in
pkgs.stdenv.mkDerivation {
  name = "pkl";
  version = "${version}";

  src = pkgs.fetchurl {
    url = "${url}";
    sha256 = "${sha}";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/pkl
    chmod +x $out/bin/pkl
  '';

  meta = {
    description = "A configuration as code language with rich validation and tooling.";
    mainProgram = "pkl";
  };
}
