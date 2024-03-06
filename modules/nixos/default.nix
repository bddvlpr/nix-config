{
  disko = {
    btrfs-single = import ./disko/btrfs-single.nix;
    luks-btrfs-single = import ./disko/luks-btrfs-single.nix;
    luks-lvm-single = import ./disko/luks-lvm-single.nix;
  };
}
