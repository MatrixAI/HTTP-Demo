# HTTP-Demo

## Installation

Building the package (as a library):

```sh
nix-build -E '(import ./pkgs.nix).python3Packages.callPackage ./default.nix {}'
```

Building the releases:

```sh
nix-build ./release.nix --attr application
nix-build ./release.nix --attr docker
```

Install into Nix user profile:

```sh
nix-env -f ./release.nix --install --attr application
```

Install into Docker:

```sh
docker load --input "$(nix-build ./release.nix --attr docker)"
```

## Running

```sh
http-demo 55555
curl http://localhost:55555/
```

Or after you have tagged your container image with `latest`:

```sh
docker run -it --rm --network=host http-demo:latest 55555
```
