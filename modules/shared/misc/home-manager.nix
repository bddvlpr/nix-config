{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
with lib; let
  cfg = config.misc.home-manager;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.misc.home-manager = {
    enable = mkOption {
      type = with types; bool;
      default = true;
      example = true;
      description = "Enable the Home Manager module.";
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs;
        nixosConfig = config;
      };
    };
  };
}
