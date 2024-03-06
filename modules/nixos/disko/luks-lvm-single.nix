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
                    type = "lvm_pv";
                    vg = "os";
                  };
                };
              };
            };
          };
        };
      };
      lvm_vg = {
        os = {
          type = "lvm_vg";
          lvs = {
            swap = {
              size = "16G";
              content.type = "swap";
            };
            system = {
              size = "100%FREE";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint =
                  if metadata.hasImpermanence
                  then "/nix"
                  else "/";
                mountOptions = ["defaults"];
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

  fileSystems = lib.mkIf metadata.hasImpermanence {"/nix".neededForBoot = true;};
}
