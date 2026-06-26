{ system ? builtins.currentSystem, ... }:
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  rev = lock.nodes.nixpkgs.locked.rev;
  narHash = lock.nodes.nixpkgs.locked.narHash;
in
import (fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz";
  sha256 = narHash;
}) ({
  inherit system;
  config = { allowUnfree = true; };
})
