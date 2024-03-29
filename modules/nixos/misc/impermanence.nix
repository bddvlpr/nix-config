{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.misc.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.misc.impermanence = {
    enable = mkOption {
      type = with types; bool;
      default = false;
      example = true;
      description = ''
        Enable impermanence mode. When enabled, the system will be
        configured to be as stateless as possible.
      '';
    };
  };

  config = {
    boot.impermanence.enable = cfg.enable;

    environment.persistence."/persistent" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager"
        "/var/log"
      ];
      files = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
