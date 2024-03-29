{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.disk.luks-btrfs;
in {
  imports = [./.];

  options.disk.luks-btrfs = {
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
                      "/root" = {
                        mountpoint = "/";
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
    };
  };
}
