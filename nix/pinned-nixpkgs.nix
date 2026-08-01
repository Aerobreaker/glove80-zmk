{
  system ? builtins.currentSystem,
}:

let
  lock = builtins.fromJSON (builtins.readFile ../flake.lock);
  pin = lock.nodes.nixpkgs.locked;

  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/${pin.owner}/${pin.repo}/archive/${pin.rev}.tar.gz";
    sha256 = pin.narHash;
  };
in

import nixpkgsSrc {
  inherit system;
  config = {
    allowUnfree = true;
  };
  overlays = [ ]; # prevent impure overlays
}
