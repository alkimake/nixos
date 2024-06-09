{pkgs, lib, ...}:
{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = lib.mkDefault true;
      sddm.theme = "catppuccin-mocha";
    };
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      loginBackground = true;
      background = "${../../../assets/wallpapers/login.png}";
    })
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];
}

