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
    # Include the results of the hardware scan.
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-a8b20255-8ea4-40e4-8cd1-d57b2d8476e9".device = "/dev/disk/by-uuid/a8b20255-8ea4-40e4-8cd1-d57b2d8476e9";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  myNixOS = {
    bundles.general-desktop.enable = true;
    bundles.users.enable = true;
    services.syncthing.enable = true;

    sddm.enable = true;
    virtualisation.enable = true;

    sharedSettings.hyprland.enable = true;
    sharedSettings.catppuccin.enable = true;
    home-users = {
      "ake" = {
        userConfig = ./home.nix;
        userSettings = {
          extraGroups = ["docker" "libvirtd" "networkmanager" "wheel"];
        };
      };
    };
    # cachix.enable = true;
  };
  system.name = "X1";
  system.nixos.label = "X1";
  system.autoUpgrade.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "kr";
    variant = "";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sof-firmware
  ];

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.mosh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking = {
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
    hostName = "X1"; # Define your hostname.
    firewall = {
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Open ports in the firewall.
      # allowedTCPPorts = [];
      # allowedUDPPorts = [];
      # Or disable the firewall altogether.
      # enable = false;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
