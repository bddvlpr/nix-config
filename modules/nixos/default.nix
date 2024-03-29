{
  boot = {
    imports = [
      ./boot/systemd-boot.nix
    ];
  };

  disko = {
    imports = [
      ./disk/luks-btrfs-impermanence.nix
      ./disk/luks-btrfs.nix
    ];
  };

  misc = {
    imports = [
      ./misc/impermanence.nix
    ];
  };

  network = {
    imports = [
      ./network/host.nix
    ];
  };

  user = {
    imports = [
      ./user/bddvlpr.nix
    ];
  };
}
