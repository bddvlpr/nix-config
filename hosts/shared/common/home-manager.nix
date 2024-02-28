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
        name = user;
        value = import ../../../homes/shared/users/${user};
      }) (lib.attrNames (builtins.readDir ../../../homes/shared/users));
    in
      builtins.listToAttrs userFiles;
  };
}
