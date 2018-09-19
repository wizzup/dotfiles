# ~/.config/nixpkgs/overlays/neovim.nix

self: super:
with self.pkgs;
with self.python3Packages;

let
    simple-websocket-server = buildPythonPackage rec {
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

    myPackages = p: with p; [
      neovim
      simple-websocket-server
      python-slugify

      python-language-server
    ];
in
{
  neovim = super.neovim.override {
    extraPython3Packages = myPackages;
  };
}

