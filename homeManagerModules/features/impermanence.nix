{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.myHomeManager.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options.myHomeManager.impermanence = {
    directories = lib.mkOption {
      default = [];
      description = ''
        directories to persist
      '';
    };
    files = lib.mkOption {
      default = [];
      description = ''
        directories to persist
      '';
    };
  };

  config = {
    home.persistence."/persist/home" = {
      directories =
        [
          "Downloads"
          "Music"
          "Pictures"
          "Projects"
          "Documents"
          "Videos"
          ".gnupg"
          ".ssh"
          ".nixops"
          ".config/dconf"
          ".local/share/keyrings"
          ".local/share/direnv"

          "nixos"
        ]
        ++ cfg.directories;
      allowOther = true;
    };
  };
}
