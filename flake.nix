{
  description = "Unfree nixpkgs wrapper";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: nixpkgs // {
    legacyPackages = builtins.mapAttrs (system: _:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
    ) nixpkgs.legacyPackages;
  };
}
