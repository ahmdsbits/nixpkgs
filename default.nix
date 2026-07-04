args@{ ... }:
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  rev = lock.nodes.nixpkgs.locked.rev;
  narHash = lock.nodes.nixpkgs.locked.narHash;
  system = 
    if args ? system then args.system
    else if builtins ? currentSystem then builtins.currentSystem
    else null;
in
import (fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz";
  sha256 = narHash;
}) ({
  inherit system;
  config = { allowUnfree = true; };
})
