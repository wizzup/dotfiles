{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let py3s = pkgs.python3.buildEnv.override  {
  extraLibs = with pkgs.python3Packages; [ jedi pyyaml ];
};
in stdenv.mkDerivation {
  name = "python3-shell";
  buildInputs = [ py3s ];

  shellHook = ''
    export PS1="\[\033[1;32m\][nix-shell:\w]\n$ \[\033[0m\]"
  '';
}

