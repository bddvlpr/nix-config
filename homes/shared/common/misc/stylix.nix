{
  inputs,
  pkgs,
  lib,
  metadata,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    image = pkgs.fetchurl {
      url = "https://files.catbox.moe/ndnmmg.jpeg";
      hash = "sha256-W053xG3oPYYftrvHUndwvrFzkuK3RXj6s2JjgJwW3bk=";
    };

    polarity = "dark";

    opacity = {
      desktop = 0.8;
      popups = 0.8;
      terminal = 0.8;
    };

    fonts = {
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };

      #monospace = {
      #  package = pkgs.geist-nf;
      #  name = "GeistMono NFM";
      #};
    };

    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
    };

    targets = {
      waybar.enable = false;
      vscode.enable = false;
    };
  };

  gtk.iconTheme = lib.mkIf metadata.isNixOS {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };

  home.packages = [pkgs.noto-fonts-cjk-sans];
}
