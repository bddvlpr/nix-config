{outputs, ...}: {
  imports =
    [
      ../shared/common
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "bddvlpr";
    stateVersion = "24.05";
  };

  identity = {
    firstName = "Luna";
    lastName = "Simons";

    email = "luna@bddvlpr.com";

    gpgKey = "42EDAE8164B99C3A4B835711AB69B6F3380869A8";
    sshKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgZVPZ2+cqT1seskNMDRtb8x+W6XkJBl9w8ZkqzkWP8 bddvlpr@dissension"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGO+uT+Htg4wwSREfUCMutIp1J9FCicwAPjj7M7utuft bddvlpr@solaris"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKY72t6PxngR/ckDL9iYT6f0ZW6inZOWWhsxhQRDO2mR bddvlpr@lavender"
    ];
  };
}
