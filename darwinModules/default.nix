{
  pkgs,
  config,
  lib,
  inputs,
  outputs,
  myLib,
  ...
}: let
  cfg = config.myDarwin;
  
  # Taking all modules in ./features and adding enables to them
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myDarwin.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features)
    {};


  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myLib.extendModules
    (name: {
      extraOptions = {
        myDarwin.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (myLib.filesIn ./bundles)
  {};

in {
  imports =
    [
      # inputs.catppuccin.homeManagerModules.catppuccin
      inputs.home-manager.darwinModules.home-manager
    ]
    ++ features
    ++ bundles;

  options.myDarwin = {
    sharedSettings = {
    };
  };

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    # programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}

