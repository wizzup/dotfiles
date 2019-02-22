# shell for working with C++

{ pkgs ? import <nixpkgs> {} }:
with pkgs;

mkShell {
  name = "gcc-sh";
  buildInputs = [ gcc ];

  shellHook = ''
    export PS1=$'\[\033[1;32m\][$name\u2234\W]\n$ \[\033[0m\]'
  '';
}
