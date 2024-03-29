{
  lib,
  config,
  outputs,
  ...
}:
with lib; {
  config = mkMerge [
    {
      users.users.bddvlpr = {
        hashedPassword = "$y$j9T$54IvHij7vYMOWGmNtQJS4/$nElqOy4L.MOJDtvOKjLIRG4cAmXia6P7HYnHNHmRRB1";
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
      };
    }
    (mkIf
      config.misc.home-manager.enable
      {
        home-manager.users.bddvlpr = import outputs.homeModules.bddvlpr;
      })
  ];
}
