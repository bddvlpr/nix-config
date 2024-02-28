{
  metadata,
  lib,
  ...
}: {
  imports = let
    userFiles = lib.attrNames (builtins.readDir ./users);
    users = map (name: import ./users/${name}) userFiles;
  in
    [
      ./home-manager.nix
      ./shells.nix
    ]
    ++ users;

  networking.hostName = metadata.host;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      substituters = ["https://cache.garnix.io"];
      trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
    };
  };
}
