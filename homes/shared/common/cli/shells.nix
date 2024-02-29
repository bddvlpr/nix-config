{
  lib,
  metadata,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;

    shellAbbrs = lib.mkMerge [
      {
        n = "nix";
        ns = "nix shell";
        nsn = "nix shell nixpkgs#";
        nb = "nix build";
        nbn = "nix build nixpkgs#";
        nf = "nix flake";
        nfu = "nix flake update";
        nr = "nix run";
        nfmt = "nix fmt";
      }
      (lib.mkIf metadata.isNixOS {
        snr = "sudo nixos-rebuild --flake /etc/nixos";
        snrs = "sudo nixos-rebuild --flake /etc/nixos switch";
      })
      (lib.mkIf metadata.isDarwin {
        snr = "darwin-rebuild --flake /etc/nixos";
        snrs = "darwin-rebuild --flake /etc/nixos switch";
      })
    ];

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -F -H --group-directories-first --git";
      cat = "${pkgs.bat}/bin/bat -pp --theme=base16";
    };

    shellInit = ''
      set fish_greeting
      export TERM=xterm-256color
    '';
  };

  programs.starship = {
    enable = true;

    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      format = "$all";

      character = {
        success_symbol = "[❯](bold mauve)";
        error_symbol = "[❯](bold maroon)";
      };

      os = {
        disabled = false;
        symbols = {
          NixOS = " ";
        };
      };

      directory.truncation_symbol = "󰄛 /";

      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "bold cyan";
      };

      nix_shell = {
        symbol = " ";
        style = "bold cyan";
      };
    };
  };
}
