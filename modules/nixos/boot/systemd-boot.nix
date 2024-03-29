{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.boot.systemd-boot;
in {
  options.boot.systemd-boot = {
    enable = mkOption {
      type = with types; bool;
      default = true;
      example = true;
      description = "Enable the systemd-boot boot loader.";
    };
    configurationLimit = lib.mkOption {
      type = types.int;
      default = 16;
      example = 16;
      description = "The maximum number of boot loader configurations to keep.";
    };
  };

  config = {
    boot.loader.systemd-boot = {
      enable = cfg.enable;
      configurationLimit = cfg.configurationLimit;
    };
  };
}
