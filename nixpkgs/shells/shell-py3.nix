{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.python3Packages;

let py3s = python3.buildEnv.override  {
  extraLibs = [ jedi ];
};
in stdenv.mkDerivation {
  name = "py3-sh";
  buildInputs = [ py3s ];

  shellHook = ''
    export PS1="\[\033[1;32m\][$name:\w]\n$ \[\033[0m\]"
  '';
}

