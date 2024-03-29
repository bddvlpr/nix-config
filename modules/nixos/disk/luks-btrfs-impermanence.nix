{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.disk.luks-btrfs-impermanence;
in {
  imports = [./.];

  options.disk.luks-btrfs-impermanence = {
    device = mkOption {
      type = with types; nullOr str;
      default = null;
      example = "sda";
      description = "The target disk to install to.";
    };
  };

  config = mkIf (cfg.device
    != null) {
    disko.devices = {
      disk = {
        single = {
          type = "disk";
          device = cfg.device;
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
                    subvolumes = {
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "/swap" = {
                        mountpoint = "/swap";
                        swap.swapfile.size = "16G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = ["mode=755"];
        };
      };
    };

    fileSystems = {
      "/nix".neededForBoot = true;
      "/persist".neededForBoot = true;
    };
  };
}
