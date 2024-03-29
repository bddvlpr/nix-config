{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.desktop.wayland;
in {
  options.desktop.wayland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Enable Hyprland desktop environment";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = import ./settings.nix;
    };
  };
}
