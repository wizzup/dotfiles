# shell.nix for nix-shell
# Overrideable ghc version by passing compiler env variable
# Example: 
# $ nix-shell shell.nix --argstr compiler ghc7103
#
# To list avaliable ghc version: 
# $ nix-env -qaPA nixos.haskell.compiler


{ pkgs ? import <nixpkgs> {}, compiler ? "ghc802" }:
with pkgs.haskell.packages.${compiler};

let
  ghc = ghcWithPackages (ps: with ps; [
          hspec
        ]);
in
  pkgs.stdenv.mkDerivation {
    name = "${compiler}-sh";
    buildInputs = [ ghc hlint ghc-mod ];

    shellHook = ''
      eval "$(egrep ^export "$(type -p ghc)")"
      export PS1="\[\033[1;32m\][$name:\W]\n$ \[\033[0m\]"
    '';
}
