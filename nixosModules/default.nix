{
  pkgs,
  config,
  lib,
  inputs,
  outputs,
  myLib,
  ...
}: let
  cfg = config.myNixOS;

in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ];

  options.myNixOS = {
    sharedSettings = {
      # hyprland.enable = lib.mkEnableOption "enable hyprland";
    };
  };

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    # programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}

