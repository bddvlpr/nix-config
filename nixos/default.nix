{
  inputs,
  self,
  withSystem,
  ...
}: {
  flake = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    mkMetadata = hostName: system: {inherit hostName system;};
    mkSystem = metadata:
      withSystem metadata.system ({pkgs, ...}:
        nixosSystem {
          inherit pkgs;
          inherit (metadata) system;
          specialArgs = {
            inherit inputs metadata;
            inherit (self) outputs;
          };
          modules =
            [./hosts/${metadata.hostName}]
            ++ builtins.attrValues self.outputs.nixosModules
            ++ builtins.attrValues self.outputs.sharedModules;
        });
  in {
    nixosConfigurations = {
      dissension = mkSystem (mkMetadata "dissension" "x86_64-linux");
    };
  };
}
