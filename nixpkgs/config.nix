# ~/.config/nixpkgs/config.nix
{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  myNeovim = callPackage ./nvim/nvim.nix { };
in
{
  # for building an unfree package with nix-shell, nix-build and nix-env
  allowUnfree = true;

  # permittedInsecurePackages = [
  #   "samba-3.6.25"
  # ];


  # my custom packages, can be install with `nix-env`
  packageOverrides = pkgs: with pkgs; {

    # myVim = vim_configurable.customize {
    #   name = "vim-with-plugins";
    #   python = true;
    #   # add here code from the example section
    # };

    # caveat: don't works with `nix-env -i`,
    #         `nvim` always call the system packages not this one
    #         only use with nix-shell -p myNeovim
    myNeovim = myNeovim;

    # common python packages with standard nvim
    pythonEnv = with pkgs; buildEnv {
      name = "pythonEnv";

      paths = with python3Packages; [
        (python.buildEnv.override {
            extraLibs = [ jedi flake8 pylint ];
        })

        myNeovim mypy
      ];

    };

    # common haskell packages with standard nvim
    haskellEnv = with pkgs; buildEnv {
      name = "haskellEnv";

      paths = with haskellPackages; [
        (ghcWithPackages (p: with p;
          [ hspec ]
        ))

        myNeovim ghc-mod hasktags ctags
        stack cabal-install hpack intero
      ];

    };

  };

}
