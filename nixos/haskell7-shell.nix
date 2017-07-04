# shell.nix for nix-shell (haskell)

{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7103" }:

let
  inherit (nixpkgs) pkgs;
  ghc = pkgs.haskell.packages.${compiler}.ghcWithPackages (ps: with ps; [
          hspec
          split
        ]);
in
pkgs.stdenv.mkDerivation {
  name = "haskell-${compiler}";

  # BUG:: ghc-mod has cabal-helper override problem on current nixos config
  #       waiting for fix, or use custom configuration
  # buildInputs = with pkgs.haskell.packages.${compiler}; [ ghc cabal-install ghc-mod hlint ];

  buildInputs = with pkgs.haskell.packages.${compiler}; [ ghc cabal-install hlint];

  shellHook = ''
    eval "$(egrep ^export "$(type -p ghc)")"
    export PS1="\[\033[1;32m\][nix-hs:\w]\n$ \[\033[0m\]"
  '';
}
