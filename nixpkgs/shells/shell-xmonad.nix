# shell for working with xmonad.hs

{ pkgs ? import <nixpkgs> {} }:
with pkgs;
with pkgs.haskellPackages;

let
  ghc = ghcWithPackages (ps: with ps; [
          xmonad
          xmonad-contrib
          xmonad-extras

          taffybar
        ]);
in
mkShell {
  name = "xmonad-sh";

  buildInputs = [ ghc hlint ];

  shellHook = ''
    eval "$(egrep ^export "$(type -p ghc)")"
    export PS1="\[\033[1;32m\][$name:\W]\n$ \[\033[0m\]"
  '';
}
