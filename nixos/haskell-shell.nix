# shell.nix for nix-shell (haskell)

{ pkgs ? import <nixpkgs> {} }:

let
  ghc = pkgs.haskellPackages.ghcWithHoogle (self: with self; [
          hspec
          split
        ]);
in
pkgs.stdenv.mkDerivation {
  name = "haskell-shell";
  buildInputs = with pkgs.haskellPackages; [ ghc cabal-install ghc-mod hlint ];

  shellHook = ''
    eval "$(egrep ^export "$(type -p ghc)")"
    export PS1="\[\033[1;32m\][ns-hs:\w]\n$ \[\033[0m\]"
  '';
}
