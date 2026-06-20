{ system ? builtins.currentSystem, ... }:
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  rev = lock.nodes.nixpkgs.locked.rev;
in
import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${rev}.tar.gz") ({
  inherit system;
  config = { allowUnfree = true; };
})
