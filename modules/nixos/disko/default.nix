{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.default
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 16;
  };
}
