# This expression file is expected to be imported by another top-level expression (default.nix)
# to test expression in nix-shell/nix-build
#
# $ nix-shell -E 'with import <nixpkgs> { }; callPackage /path/to/this/default.nix { }'

{ stdenv, haskellPackages, fetchFromGitHub }:

with haskellPackages;

mkDerivation {
  pname = "ghcid";
  version = "0.7.1";
  license = stdenv.lib.licenses.bsd3;

  src = fetchFromGitHub {
    owner = "ndmitchell";
    repo = "ghcid";
    rev = "v0.7.1";
    sha256 = "0f733bg2mdpvm8l95vwgxqb7pwmcnjr41531785nw5s7mk9mk9dl";
  };

  buildDepends = [
    ansi-terminal cmdargs extra fsnotify tasty tasty-hunit terminal-size
  ];
}
