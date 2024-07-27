{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    (catppuccin-sddm.override
      {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "9";
        background = "${../../../assets/wallpapers/login.png}";
        loginBackground = true;
      })
  ];
}
