{
  pkgs,
  config,
  lib,
  metadata,
  ...
}: let
in {
  programs.git = {
    enable = true;
    userName = with config.identity; "${firstName} ${lastName}";
    userEmail = config.identity.email;

    package = pkgs.gitFull;

    signing = {
      key = config.identity.gpgKey;
      signByDefault = true;
    };

    extraConfig = lib.mkMerge [
      {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      }
      (lib.mkIf metadata.isNixOS {
        credential.helper = "${config.programs.git.package}/bin/git-credential-libsecret";
      })
    ];
  };
}
