# ~/.config/nixpkgs/overlays/neovim.nix

self: super:
with self.pkgs;
with self.python3Packages;

let
    # for ghost-text
    simple-websocket-server = buildPythonPackage rec {
      version = "git";
      pname = "simple-websocket-server";
      name = "${pname}-${version}";

      src = fetchFromGitHub {
        owner = "dpallot";
        repo = "simple-websocket-server";
        rev = "34e6def93502943d426fb8bb01c6901341dd4fe6";
        sha256 = "19rcpdx4vxg9is1cpyh9m9br5clyzrpb7gyfqsl0g3im04m098n5";
      };

      doCheck = false;
    };

    myPackages = p: with p; [
      simple-websocket-server
      python-slugify

      jedi
    ];
in
{
  neovim = super.neovim.override {
    extraPython3Packages = myPackages;
  };

  # neovim = super.neovim.override {
  #   extraPython3Packages = myPackages;
  #   configure = {
  #     customRC = ''
  #       " here your custom configuration goes!
  #       set ignorecase
  #       set infercase
  #       set number
  #       set relativenumber
  #     '';
  #     packages.myVimPackage = with pkgs.vimPlugins; {
  #       # see examples below how to use custom packages
  #       start = [ ale LanguageClient-neovim ];
  #       opt = [ ];
  #       };
  #     };
  # };
}

