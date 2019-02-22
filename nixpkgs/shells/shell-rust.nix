# shell for working with rust

{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  rust-src = rustPlatform.rustcSrc;
in
mkShell {
  name = "rust-sh";
  buildInputs = [ cargo rustracer rust-src];

  shellHook = ''
    export PS1=$'\[\033[1;32m\][$name\u2234\W]\n$ \[\033[0m\]'
    export RACER_BIN=${rustracer}/bin/racer
    export RUST_SRC=${rust-src}

    # export RUST_BACKTRACE = 1;
  '';
}
