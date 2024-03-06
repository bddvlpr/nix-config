{
  lib,
  outputs,
  metadata,
  ...
}: {
  imports = [
    (outputs.nixosModules.disko.luks-btrfs-single {
      inherit lib metadata;
      device = "/dev/vda";
    })
  ];

  boot = {
    initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
    kernelModules = ["kvm_amd"];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.06";
}
