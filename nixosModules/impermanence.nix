{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.myNixOS.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.persist-retro.nixosModules.persist-retro
  ];

  options.myNixOS.impermanence = {
    volumeGroup = lib.mkOption {
      default = "btrfs_vg";
      description = ''
        Btrfs volume group name
      '';
    };

    directories = lib.mkOption {
      default = [];
      description = ''
        directories to persist
      '';
    };
  };

  config = {
    fileSystems."/persist".neededForBoot = true;
    programs.fuse.userAllowOther = true;

    environment.persistence = let
      persistentHomes = builtins.mapAttrs (name: user: {
        directories = config.home-manager.users."${name}".myHomeManager.impermanence.directories;
        files = config.home-manager.users."${name}".myHomeManager.impermanence.files;
      }) (config.myNixOS.home-users);
    in {
      "/persist/users".users = persistentHomes;
      "/persist/system" = {
        hideMounts = true;
        directories =
          [
            "/etc/nixos"
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
            {
              directory = "/var/lib/colord";
              user = "colord";
              group = "colord";
              mode = "u=rwx,g=rx,o=";
            }
          ]
          ++ cfg.directories;
        files = [
          "/etc/machine-id"
          {
            file = "/var/keys/secret_file";
            parentDirectory = {mode = "u=rwx,g=,o=";};
          }
        ];
      };
    };

  };
}

