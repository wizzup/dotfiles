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

  # https://github.com/moretea/yarn2nix
  yarn2nix = callPackage (fetchFromGitHub {
    owner = "moretea";
    repo = "yarn2nix";
    rev = "master";
    sha256 = "0h2kzdfiw43rbiiffpqq9lkhvdv8mgzz2w29pzrxgv8d39x67vr9";
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

      # diagrams = pkgs.haskell.lib.overrideCabal diagrams (drv: {
      #   configureFlags = [ "-f cairo" ];
      #   libraryHaskellDepends = with haskellPackages; [
      #     diagrams-cairo
      #   ] ++ drv.libraryHaskellDepends;
      # });
      #
      # diagrams = pkgs.haskell.lib.addBuildDepends drv
      #   (with haskellPackages; [
      #     diagrams-cairo
      #   ]);
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

    all-hies = callPackage (fetchFromGitHub {
      owner = "infinisil";
      repo = "all-hies";
      rev = "master";
      sha256 = "1pmrmc0y94434z3znk69wpi8lgfblci4a1py9k0ri9fifsqkb7sn";
    }) {};

    hie = all-hies.selection { selector = p: { inherit (p) ghc865; }; };

    ## common haskell packages for using with nvim
    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = with haskellPackages; [
        ## FIXME: this doesn't seem to work, ghc won't find any of these libs
        (ghcWithPackages (p: with p;
          [
            split
          ]
        ))

        ## supported tools
        hasktags ctags
        stack cabal-install
        doctest
        hoogle
        hie
        hlint

        ## need for readline's bind
        bashInteractive
      ];
    };

    # yarn2nix binary
    yarn2nix = yarn2nix.yarn2nix;
    mkYarnPackage = null;

    ## suckless terminal
    ## TODO: use st.patches
    ##       move to /etc/nixos/configuration.nix
    # st = super.st.override {
    #   conf = builtins.readFile ./st/config.h;
    # };
  };
}
