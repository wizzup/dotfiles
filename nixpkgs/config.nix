# ~/.config/nixpkgs/config.nix
{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  hie-nix = callPackage (fetchFromGitHub {
    owner = "wizzup";
    repo = "hie-nix";
    rev = "42a564ad65808b60d091a8e7e1b8c4de12cf9b2b";
    sha256 = "0xs7kpv40lzd1bb734biy0mln21mbzly5frw48hw07amil5wm5j1";
  }) {};
in
{
  # for building an unfree package with nix-shell, nix-build and nix-env
  allowUnfree = true;
  allowBroken = true;
  # allowUnsupportedSystem = true;

  oraclejdk.accept_license = true;

  # permittedInsecurePackages = [
  #   "samba-3.6.25"
  # ];

  # my custom packages, can be install with `nix-env`
  packageOverrides = super: {

    # WARNING: not sure if it the proper way to override haskellPackages
    #          if there is any haskellPackages build error
    #          comment out this block before do a bug report
    # see : https://nixos.org/nixpkgs/manual/#how-to-override-packages-in-all-compiler-specific-package-sets
    haskellPackages = super.haskellPackages // {
      # jailbreak that works
      clay = super.haskell.lib.doJailbreak super.haskellPackages.clay;

      # jailbreak that still failed
      gtk2hs-buildtools = super.haskell.lib.doJailbreak super.haskellPackages.gtk2hs-buildtools;

      # binaries that need rebuild for RTS options support
      steeloverseer = super.haskell.lib.appendConfigureFlag
            super.haskellPackages.steeloverseer "--ghc-option=-rtsopts";

      doctest = super.haskell.lib.appendConfigureFlag
            super.haskellPackages.doctest "--ghc-option=-rtsopts";
    };

    # for codingame shell (ghc844)
    haskell = super.haskell // {
      packages = super.haskell.packages // {
        ghc844 = super.haskell.packages.ghc844 // {
         doctest = super.haskell.lib.appendConfigureFlag
            super.haskell.packages.ghc844.doctest "--ghc-option=-rtsopts";
         hasktags = super.haskell.lib.appendConfigureFlag
            super.haskell.packages.ghc844.hasktags "--ghc-option=-rtsopts";
    };};};

    ## Using custom namespace seem to be better and safer way to get
    ## broken haskell packages working quickly
    # myHaskellPackages = {
    #   aeson = haskell.lib.overrideCabal haskellPackages.aeson (old:
    #           { jailbreak = true; });
    #
    #   sos = haskell.lib.appendConfigureFlag
    #         haskellPackages.steeloverseer "--ghc-option=-rtsopts";
    #
    #   gtk2hs-buildtools = haskell.lib.doJailbreak
    #                       haskellPackages.gtk2hs-buildtools;
    #
    #   ghcid = callPackage ./ghcid/default.nix {};
    # };

    # common python packages with standard nvim
    myPythonEnv = buildEnv {
      name = "myPythonEnv";
      paths = with python3Packages; [
        (python3.withPackages (p: with p;[
          # jedi
          # flake8
          pylint
        ]))

        pip
        python-language-server
        # mypy

        # need for readline's bind
        bashInteractive
      ];
    };

    ## common haskell packages for using with nvim
    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = with haskellPackages; [
        ## FIXME: this doesn't seem to work, ghc won't find any of these libs
        # (ghcWithPackages (p: with p;
        #   [
        #     split
        #   ]
        # ))

        ## supported tools
        hasktags ctags
        stack cabal-install
        doctest
        hie

        ## need for readline's bind
        bashInteractive
      ];
    };

    hie =
      if pkgs.lib.hasPrefix ghc.version "ghc80" then hie-nix.hie80 else
      if pkgs.lib.hasPrefix ghc.version "ghc82" then hie-nix.hie82 else
      if pkgs.lib.hasPrefix ghc.version "ghc84" then hie-nix.hie84 else
                                                     hie-nix.hie86;
  };
}
