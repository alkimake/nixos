{config, ...}: let
  cfg = config.myNixOS;
in {
  services = {
    syncthing = {
      enable = true;
      user = "${cfg.userName}";
      dataDir = "/home/${cfg.userName}/Documents"; # Default folder for new synced folders
      configDir = "/home/${cfg.userName}/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys
      guiAddress = "0.0.0.0:8384";
    };
  };
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
