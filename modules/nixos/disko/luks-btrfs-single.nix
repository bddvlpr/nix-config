{
  lib,
  device,
  metadata,
  ...
}: {
  imports = [./.];

  disko.devices = lib.mkMerge [
    {
      disk = {
        single = {
          type = "disk";
          inherit device;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["defaults"];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  askPassword = true;
                  settings.allowDiscards = true;
                  content = {
                    type = "btrfs";
                    extraArgs = ["-f"];
                    subvolumes = lib.mkMerge [
                      {
                        "/nix" = {
                          mountpoint = "/nix";
                          mountOptions = ["compress=zstd" "noatime"];
                        };
                        "/swap" = {
                          mountpoint = "/swap";
                          swap.swapfile.size = "16G";
                        };
                      }
                      (
                        if metadata.hasImpermanence
                        then {
                          "/persist" = {
                            mountpoint = "/persist";
                            mountOptions = ["compress=zstd" "noatime"];
                          };
                        }
                        else {
                          "/rootfs" = {
                            mountpoint = "/";
                            mountOptions = ["compress=zstd" "noatime"];
                          };
                        }
                      )
                    ];
                  };
                };
              };
            };
          };
        };
      };
    }
    (lib.mkIf metadata.hasImpermanence
      {
        nodev = {
          "/" = {
            fsType = "tmpfs";
            mountOptions = ["mode=755"];
          };
        };
      })
  ];

  fileSystems = lib.mkIf metadata.hasImpermanence {
    "/nix".neededForBoot = true;
    "/persist".neededForBoot = true;
  };
}
