with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "random-project";

  buildInputs = [
    # System deps
    gzip
    bzip2
    python3Packages.virtualenv
  ];

  env = buildEnv { name = name; paths = buildInputs; };

  shellHook = ''
    export PS1="\[\033[1;32m\][${name}:\w]\n$ \[\033[0m\]"
    virtualenv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
  '';
}
