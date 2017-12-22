# create docker images using nix-build
# load with `docker load < result`
# run with docker -it for interactive with vt

{ pkgs ? import <nixpkgs> {} }:

with pkgs;

dockerTools.buildImage {
    name = "basic";
    # tag = "latest";

    contents = [
       bashInteractive
       coreutils
       ];

    runAsRoot = ''
      #!${stdenv.shell}
      mkdir -p /mydata
    '';

    config = {
      Entrypoint = [ "/bin/bash" ];
#      Cmd = [ "/bin/busybox" "sh" ];
      WorkingDir = "/mydata";
      Volumes = {
        "/mydata" = {};
      };
    };
}
