{
  flake = {
    homeManagerModules = import ./home-manager;
    nixosModules = import ./nixos;
    sharedModules = import ./shared;
  };
}
