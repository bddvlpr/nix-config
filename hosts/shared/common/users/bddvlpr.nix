{
  lib,
  metadata,
  pkgs,
  ...
}: {
  users.users.bddvlpr = let
    defaults = {
      description = "Luna Simons";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgZVPZ2+cqT1seskNMDRtb8x+W6XkJBl9w8ZkqzkWP8 bddvlpr@dissension"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGO+uT+Htg4wwSREfUCMutIp1J9FCicwAPjj7M7utuft bddvlpr@solaris"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKY72t6PxngR/ckDL9iYT6f0ZW6inZOWWhsxhQRDO2mR bddvlpr@lavender"
      ];
    };
  in
    (
      if metadata.isNixOS
      then {
        isNormalUser = true;
        extraGroups = ["wheel"];
        hashedPassword = "$y$j9T$Zz5fAw7uCJYjrO1uGgoOc.$zExQOgZs2oA4cM7UYJpnaAA6W.sXFA9sAw4fiiE/fa6";
      }
      else if metadata.isDarwin
      then {
        home = "/Users/bddvlpr";
      }
      else {}
    )
    // defaults;
}
