{outputs, ...}: {
  imports = builtins.attrValues (outputs.homeManagerModules);

  home = {
    username = "bddvlpr";
    stateVersion = "24.05";
  };

  programs.discocss.enable = true;
}
