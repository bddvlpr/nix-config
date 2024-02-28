{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.identity = rec {
    firstName = mkOption {
      type = types.str;
      description = "The first name of the user";
    };

    lastName = mkOption {
      type = types.str;
      description = "The last name of the user";
    };

    email = mkOption {
      type = types.str;
      description = "The email of the user";
    };

    gpgKey = mkOption {
      type = types.nullOr types.str;
      description = "The GPG key of the user";
    };

    sshKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "The SSH key(s) of the user";
    };
  };
}
