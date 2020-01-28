# ~/.config/nixpkgs/config.nix

{ pkgs ? import <nixpkgs> {} }:
with pkgs;

{
  allowUnfree = true;
  allowBroken = true;
  # allowUnsupportedSystem = true;

  oraclejdk.accept_license = true;
  android_sdk.accept_license = true;

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
      ## jailbreak that works
      # clay = super.haskell.lib.doJailbreak super.haskellPackages.clay;

      ## jailbreak that still failed
      # gtk2hs-buildtools = super.haskell.lib.doJailbreak super.haskellPackages.gtk2hs-buildtools;

      ## binaries that need rebuild for RTS options support
      # steeloverseer = super.haskell.lib.appendConfigureFlag
      #  super.haskellPackages.steeloverseer "--ghc-option=-rtsopts";
      #
      # doctest = super.haskell.lib.appendConfigureFlag
      #   super.haskellPackages.doctest "--ghc-option=-rtsopts";

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
         Diff = super.haskell.lib.overrideCabal
            super.haskell.packages.ghc844.Diff (old: { doCheck = false; });
    };};};

    # common python packages with standard nvim
    myPythonEnv = buildEnv {
      name = "myPythonEnv";
      paths = with python3Packages; [
        (python3.withPackages (p: with p;[
          jedi
          flake8
          black
          # pylint
          pandas
          pygame
        ]))

        pip
        python-language-server
        # pylint
        # mypy

        # need for readline's bind
        bashInteractive
      ];
    };

    ghcides = import (fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {};
    ghcide = ghcides.ghcide-ghc865;
    # ghcide = ghcides.ghcide-ghc881;

    all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
    hie = all-hies.selection {
      selector = p: { inherit (p) ghc865; };
    };

    ## common haskell packages for using with nvim
    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = (with haskellPackages; [
        (ghcWithPackages (p: with p;
          [
            split
            conduit
            extra
          ]
        ))

        ## ghc specific supported tools
        hasktags
        hoogle
        doctest
        apply-refact
        hindent
      ]) ++ [
        ## common supported tools
        nvim_hs
        ghcide
        hlint
        stylish-haskell
        ctags
        stack cabal-install

        ## need for readline's bind
        bashInteractive
      ];

      postBuild = ''
        eval "$(egrep ^export "$(type -p ghc)")"
        export PS1="\[\033[1;32m\][$name:\W]\n$ \[\033[0m\]"
        '';
    };

    # yarn2nix binary
    yarn2nix_repo = import (fetchTarball "https://github.com/moretea/yarn2nix/tarball/master") {};
    yarn2nix = yarn2nix_repo.yarn2nix;
    mkYarnPackage = yarn2nix.mkYarnPackage;

    ## suckless terminal
    ## TODO: use st.patches
    ##       move to /etc/nixos/configuration.nix
    # st = super.st.override {
    #   conf = builtins.readFile ./st/config.h;
    # };

    # all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
    # hie = all-hies.selection { selector = p: { inherit (p) ghc865; }; };

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
  };
}
