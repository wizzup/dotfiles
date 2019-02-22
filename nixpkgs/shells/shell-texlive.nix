{ pkgs ? import <nixpkgs> {}}:

with pkgs;

let
  tex = texlive.combine {
  inherit (texlive)
    scheme-small

    floatflt
    wasysym
    fdsymbol
    soul
    ;
  };

in mkShell {
  name = "texlive-sh";

  buildInputs = [
    tex
  ];

  shellHook = ''
    export PS1="\[\033[1;32m\][$name:\W]\n$ \[\033[0m\]"
  '';
}
