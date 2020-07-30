{ stdenvNoCC, lib, nix-gitignore, makeWrapper, socat }:

stdenvNoCC.mkDerivation {
  name = "http-demo";
  src = nix-gitignore.gitignoreSource [] ./.;
  nativeBuildInputs = [ makeWrapper ];
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    mkdir -p "$out/bin"
    install -m 555 ./server.sh "$out/bin/http-demo"
  '';
  postFixup = ''
    wrapProgram $out/bin/http-demo \
      --set PATH ${lib.makeBinPath [
        socat
      ]}
  '';
}
