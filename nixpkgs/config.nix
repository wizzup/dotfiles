# ~/.config/nixpkgs/config.nix
{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  hie-nix = fetchFromGitHub {
      owner = "domenkozar";
      repo = "hie-nix";
      rev = "96af698f0cfefdb4c3375fc199374856b88978dc";
      sha256 = "1ar0h12ysh9wnkgnvhz891lvis6x9s8w3shaakfdkamxvji868qa";
    };
in
{
  # for building an unfree package with nix-shell, nix-build and nix-env
  allowUnfree = true;

  # permittedInsecurePackages = [
  #   "samba-3.6.25"
  # ];

  # my custom packages, can be install with `nix-env`
  packageOverrides = super: {

    ghcid = callPackage ./ghcid/default.nix {};

    # common python packages with standard nvim
    myPythonEnv = buildEnv {
      name = "myPythonEnv";
      paths = with python3Packages; [
        (python3.withPackages (p: with p;[
          jedi flake8 pylint
        ]))

        mypy
      ];
    };

    # common haskell packages with standard nvim
    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = with super.haskellPackages; [
        (ghcWithPackages (p: with p;
          [
            fgl
            split
            lens
          ]
        ))

        myHasktags ctags
        stack cabal-install
        ghcid
        hie84
        hdevtools
        hlint
        brittany
        doctest
      ];
    };

    # packages which not in nixpkgs
    hie80 = (import hie-nix { }).hie80;
    hie82 = (import hie-nix { }).hie82;
    hie84 = (import hie-nix { }).hie84;
  };
}
