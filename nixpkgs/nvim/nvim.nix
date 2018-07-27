# neovim with simple-websocket-server for ghostText webextensions

{ neovim, python3Packages, fetchFromGitHub }:

let
    simple-websocket-server = python3Packages.buildPythonPackage rec {
      version = "git";
      pname = "simple-websocket-server";
      name = "${pname}-${version}";

      src = fetchFromGitHub {
        owner = "dpallot";
        repo = "simple-websocket-server";
        rev = "master";
        sha256 = "19rcpdx4vxg9is1cpyh9m9br5clyzrpb7gyfqsl0g3im04m098n5";
      };

      doCheck = false;
    };
in
neovim.override {
  extraPython3Packages = with python3Packages; [
    # vim-ghost
    python-slugify
    simple-websocket-server
  ];

  # configure = {
  #   customRC = ''
  #     # here your custom configuration goes!
  #   '';
  #   packages.myVimPackage = with pkgs.vimPlugins; {
  #     # see examples below how to use custom packages
  #     start = [
  #       vim-ghost
  #     ];
  #     opt = [ ];
  #   };
  # };
}
