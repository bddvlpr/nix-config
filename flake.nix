{
  description = "Luna's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;

    forSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    mkPackages = arch: nixpkgs.legacyPackages.${arch};
    mkMetadata = host: type: optionals: {
      inherit host type;
      isNixOS = type == "nixos";
      isDarwin = type == "darwin";
      isImpermanent = optionals.impermanent or false;
    };
    mkHost = metadata:
      (
        if metadata.isNixOS
        then nixpkgs.lib.nixosSystem
        else if metadata.isDarwin
        then nix-darwin.lib.darwinSystem
        else throw "Unknown host type: ${metadata.type}"
      ) {
        modules = [
          ./hosts/shared/common
          ./hosts/shared/${metadata.type}
          ./hosts/${metadata.type}/${metadata.host}
        ];
        specialArgs = {inherit inputs outputs metadata;};
      };
  in {
    formatter = forSystems (system: (mkPackages system).alejandra);

    nixosModules = import ./modules/nixos;
    darwinModules = import ./modules/darwin;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      dissension = mkHost (mkMetadata "dissension" "nixos" {impermanent = true;});
    };

    darwinConfigurations = {
      lavender = mkHost (mkMetadata "lavender" "darwin" {});
    };
  };
}
