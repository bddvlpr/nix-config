{
  pkgs,
  inputs,
  ...
}:
pkgs.mkShell {
  buildInputs = let
    sops-pkgs = inputs.sops.packages.${pkgs.system};
    home-manager-pkgs = inputs.home-manager.packages.${pkgs.system};
  in [
    sops-pkgs.sops-init-gpg-key
    home-manager-pkgs.default
  ];
}
