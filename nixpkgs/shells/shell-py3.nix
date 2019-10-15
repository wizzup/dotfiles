{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  py3s = python3.withPackages( ps: with ps; [
    requests
  ]);
in
  stdenv.mkDerivation {
  name = "py3-sh";
  buildInputs = [ py3s ];

  shellHook = ''
    export PS1="\[\033[1;32m\][$name:\w]\n$ \[\033[0m\]"
  '';
}
