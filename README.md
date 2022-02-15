# HTTP-Demo

## Installation

### Nix/NixOS

Building the package:

```sh
nix-build -E '(import ./pkgs.nix).callPackage ./default.nix {}'
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

### Docker

Install into Docker:

```sh
docker load --input "$(nix-build ./release.nix --attr docker)"
```

## Usage

```sh
http-demo 55555
curl http://localhost:55555/
```

Or after you have tagged your container image with `latest`:

```sh
docker run -it --rm --network=host http-demo:latest 55555
```

Or with port mapping:

```sh
docker run -it --rm -p 55555:55555 http-demo:INSERTYOURTAG 55555
```

## Deployment

### Deploying to AWS ECS:

First login to AWS ECR:

```sh
aws --profile=matrix ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 015248367786.dkr.ecr.ap-southeast-2.amazonaws.com
```

Proceed to build the container image and upload it:

```sh
repo="015248367786.dkr.ecr.ap-southeast-2.amazonaws.com" && \
build="$(nix-build ./release.nix --attr docker)" && \
loaded="$(docker load --input "$build")" && \
name="$(cut -d':' -f2 <<< "$loaded" | tr -d ' ')" && \
tag="$(cut -d':' -f3 <<< "$loaded")" && \
docker tag "${name}:${tag}" "${repo}/http-demo:${tag}" && \
docker tag "${name}:${tag}" "${repo}/http-demo:latest" && \
docker push "${repo}/http-demo:${tag}" && \
docker push "${repo}/http-demo:latest"
```

Because the container is built with an `Entrypoint`, set the `Command` to only the parameters.
