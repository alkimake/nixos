# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";  # Add this line

  networking.hostName = "MBA"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.nix-daemon.enable = true;


  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };
  myDarwin = {
    bundles.nix.enable = true;
    users.enable = true;
  };

  programs.zsh.enable = true;
  system.stateVersion = 5;
}
