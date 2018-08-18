# ~/.config/nixpkgs/config.nix
{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  hie-nix = fetchFromGitHub {
    owner = "domenkozar";
    repo = "hie-nix";
    rev = "8f04568aa8c3215f543250eb7a1acfa0cf2d24ed";
    sha256 = "06ygnywfnp6da0mcy4hq0xcvaaap1w3di2midv1w9b9miam8hdrn";
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

    # https://github.com/MarcWeber/hasktags/issues/52
    myHasktags = super.haskellPackages.hasktags.overrideAttrs (
        self : rec { doCheck = false;}
    );

    # myVim = vim_configurable.customize {
    #   name = "vim-with-plugins";
    #   python = true;
    #   # add here code from the example section
    # };

    # caveat: don't works with `nix-env -i`,
    #         `nvim` always call the system packages not this one
    #         only use with nix-shell -p myNeovim
    myNeovim = callPackage ./nvim/nvim.nix { };

    # common python packages with standard nvim
    myPythonEnv = buildEnv {
      name = "myPythonEnv";
      paths = with python3Packages; [
        (python.buildEnv.override {
            extraLibs = [ jedi flake8 pylint ];
        })

        mypy
      ];
    };

    # common haskell packages with standard nvim
    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = with super.haskellPackages; [
        (ghcWithPackages (p: with p;
          [ doctest fgl split ]
        ))

        hie82 myHasktags ctags
        stack
        # intero ghc-mod
      ];
    };

    # packages which not in nixpkgs
    hie80 = (import hie-nix { }).hie80;
    hie82 = (import hie-nix { }).hie82;

  };
}
