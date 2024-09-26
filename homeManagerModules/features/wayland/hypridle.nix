{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = [inputs.matcha.packages.${pkgs.system}.default];

  wayland.windowManager.hyprland.settings.exec-once = [
    # Start inhibitor daemon with inhibit disabled
    "${lib.getExe' inputs.matcha.packages.${pkgs.system}.default "matcha"} --daemon --off"
  ];
  wayland.windowManager.hyprland.settings.bindl = [
    # ", switch:on:Lid Switch, exec, ${lib.getExe' pkgs.systemd "systemctl"} suspend"
    ", switch:on:Lid Switch, exec, ${lib.getExe config.programs.hyprlock.package}"
  ];

  services.hypridle = {
    enable = true;
    settings = let
      hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
      loginctl = lib.getExe' pkgs.systemd "loginctl";
      systemctl = lib.getExe' pkgs.systemd "systemctl";
      hyprlock = lib.getExe config.programs.hyprlock.package;
    in rec {
      general = {
        before_sleep_cmd = "${loginctl} lock-session";
        lock_cmd = "pidof hyprlock || ${hyprlock}";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      /*
      TODO have these listeners in this order:
      1. dim screen (brightnessctl)
      2. turn off screen (hyprctl dpms)
      3. suspend (systemctl, also fix the before_sleep_cmd to actually run on suspend)
      */
      listener = [
        {
          timeout = 300;
          on-timeout = general.lock_cmd;
        }
        {
          timeout = 600;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 660;
          on-timeout = "${systemctl} suspend";
          # Check if plugged in before suspending
          condition = "${lib.getExe' pkgs.acpi "acpi"} | grep -q 'Charging'";
        }
      ];
    };
  };
}
