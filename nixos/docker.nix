# create docker images using nix-build
# load with `docker load < result`
# run with docker -it for interactive with vt

{ pkgs ? import <nixpkgs> {} }:

with pkgs;

pkgs.dockerTools.buildImage {
    name = "basic";
    # tag = "latest";

    contents = with pkgs; [
       bashInteractive
       coreutils
       ];

    runAsRoot = ''
      #!${stdenv.shell}
      mkdir -p /data
    '';

    config = {
      Entrypoint = [ "/bin/bash" ];
#      Cmd = [ "/bin/busybox" "sh" ];
      WorkingDir = "/data";
      Volumes = {
        "/data" = {};
      };
    };
  }
