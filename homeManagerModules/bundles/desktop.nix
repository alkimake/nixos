{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {

  options = {
    myHomeManager.startupScript = lib.mkOption {
      default = "";
      description = ''
        Startup script
      '';
    };
  };

  config = {
    myHomeManager.rofi.enable = lib.mkDefault true;
    myHomeManager.alacritty.enable = lib.mkDefault true;
    myHomeManager.kitty.enable = lib.mkDefault true;

    myHomeManager.gtk.enable = lib.mkDefault true;
    
    qt.enable = true;
    qt.platformTheme = "gtk";
    qt.style.name = "adwaita-dark";

    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "adwaita-dark";
    };

    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["neovide.desktop"];
      # "application/pdf" = ["zathura.desktop"];
      "image/*" = ["imv.desktop"];
      "video/png" = ["mpv.desktop"];
      "video/jpg" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
    };

    catppuccin.flavor = "mocha";

    programs.imv = {
      enable = true;
      settings = {
        options.background = "${config.colorScheme.colors.base00}";
      };
    };

    services.mako = {
      enable = true;
      backgroundColor = "#${config.colorScheme.colors.base01}";
      borderColor = "#${config.colorScheme.colors.base0E}";
      borderRadius = 5;
      borderSize = 2;
      textColor = "#${config.colorScheme.colors.base04}";
      defaultTimeout = 10000;
      layer = "overlay";
    };

    home.packages = with pkgs; [
      feh
      polkit
      polkit_gnome
      lxsession
      pulsemixer
      pavucontrol
      adwaita-qt
      pcmanfm
      libnotify

      pywal
      neovide
      mpv

      lm_sensors
      upower

      kitty

    ];

  };
}
