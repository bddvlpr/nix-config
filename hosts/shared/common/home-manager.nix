{
  metadata,
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager."${metadata.type}Modules".default
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs metadata;
    };
    users = let
      userFiles = map (user: {
        name =
          lib.strings.removeSuffix ".nix"
          user;
        value = import ../../../homes/users/${user};
      }) (lib.attrNames (builtins.readDir ../../../homes/users));
    in
      builtins.listToAttrs userFiles;
  };
}
