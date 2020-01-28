# ~/.config/nixpkgs/overlays/neovim.nix

self: super:

let
    # for ghost-text
    simple-websocket-server = super.python3Packages.buildPythonPackage rec {
      version = "git";
      pname = "simple-websocket-server";
      name = "${pname}-${version}";

      # src = fetchTarball "https://github.com/dpallot/simple-websocket-server/tarball/master";
      src = super.fetchFromGitHub {
        owner = "dpallot";
        repo = "simple-websocket-server";
        rev = "34e6def93502943d426fb8bb01c6901341dd4fe6";
        sha256 = "19rcpdx4vxg9is1cpyh9m9br5clyzrpb7gyfqsl0g3im04m098n5";
      };

      doCheck = false;
    };

  commonRC = builtins.readFile "/data/works/dotfiles/nixpkgs/overlays/init.common.vim";

  mk_nvim =
    { customRC ? "",
      plugins ? [],
      extraPython3Packages ? []
    }:
    super.neovim.override {

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;

      configure = {
        customRC = commonRC + customRC;

        packages.myVimPackage = with super.pkgs.vimPlugins; {
          start =  [
            # only what in commonRC
            base16-vim
            vim-tmux-navigator
            vim-airline
            nerdtree
            easy-align
            rainbow
            tcomment_vim
          ] ++ plugins;
        };
      };
  };

  nvimpy = mk_nvim {
    # customRC = builtins.readFile "/data/works/dotfiles/nvim/init-py.vim";
    plugins = with super.pkgs.vimPlugins; [
      coc-nvim
    ];
  };

  nvimhs = mk_nvim {
    # customRC = builtins.readFile "/data/works/dotfiles/nvim/init-hs.vim";
    plugins = with super.pkgs.vimPlugins; [
      coc-nvim
    ];
  };

in
{
  nvim_base = mk_nvim {
    plugins = with super.pkgs.vimPlugins; [
      # zero config plugins
      tcomment_vim
      fugitive
      vim-gitgutter
      tagbar
      vim-surround
      ctrlp-vim

      ale
      vim-nix
      # vim-ghost
      # coc-nvim
    ];
    customRC = ''
      :echohl WarningMsg | echo "Don't panic!" | echohl None
      '';
  };

  nvim_my = super.buildEnv {
    name = "nvim_my";
    paths = [ self.nvim_base ]
      ++ (with super;[
        tmux
        git
        nix

        # TODO: check if ghc is override by downstream
        # haskell stuffs
        # haskellPackages.ghc-mod  # build failed
        ghc
        cabal-install
        hlint
        hie
        haskellPackages.hdevtools
        # ghcid
        ghcide

        # python stuffs
        (python3.withPackages(p: with p;[
          python-language-server
          pylint
          flake8
          autopep8
          mypy
        ]))
      ]);
  };

  nvim_py = super.buildEnv {
    name = "nvim_py";
    paths = [ nvimpy ]
      ++ (with super;[
        tmux
        git
        nix
        (python3.withPackages(p: with p;[
          python-language-server
          pylint
          flake8
          autopep8
        ]))
      ]);
  };

  nvim_hs = super.buildEnv {
    name = "nvim_hs";
    paths = [
      nvimhs
      super.git
      super.ghcide
    ];
  };

}
