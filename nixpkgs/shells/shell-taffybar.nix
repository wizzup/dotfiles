# shell for working with taffybar.hs

{ pkgs ? import <nixpkgs> {} }:
with pkgs;
with pkgs.haskellPackages;

let
  ghc = ghcWithPackages (ps: with ps; [
          taffybar
        ]);
in
mkShell {
  name = "taffybar-sh";
  buildInputs = [ hlint ghc ];

  shellHook = ''
    eval "$(egrep ^export "$(type -p ghc)")"
    export PS1=$'\[\033[1;32m\][$name\u2234\W]\n$ \[\033[0m\]'
  '';
}
