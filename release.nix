{ pkgs ? import ./pkgs.nix }:

with pkgs;
rec {
  application = callPackage ./default.nix {};
  docker = dockerTools.buildImage {
    name = application.name;
    contents = [ application bash ];
    config = {
      Entrypoint = [ "/bin/http-demo" ];
    };
  };
}
