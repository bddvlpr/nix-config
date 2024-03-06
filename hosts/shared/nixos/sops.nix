{inputs, ...}: {
  imports = [
    inputs.sops.nixosModules.sops
  ];

  # TODO: Configure sops and default sec file.
}
