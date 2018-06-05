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
        sha256 = "001ppb9xv6ca64p2zgpiwjdba34yafph4imk9nisd2xrjibgnni3";
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
