{
  imports = [
    ./app/communication/discord.nix
    ./app/communication/slack.nix
    ./cli/git.nix
    ./cli/helix.nix
    ./cli/shells.nix
    ./misc/stylix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
