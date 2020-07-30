import (
  let rev = "02b95cf5edc836a49de64dedb6bca128f5f8f9af"; in
  fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/${rev}.tar.gz"
) {}
