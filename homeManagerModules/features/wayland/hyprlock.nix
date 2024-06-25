{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.hyprlock = let
    primaryMonitor = (builtins.elemAt config.myHomeManager.monitors 0).name;
  in {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.default;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 1;
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
      };

      background =
        map (m: {
          monitor = "${m.name}";
          path = "${../../../assets/wallpapers/lock.jpg}";
          # path = "${m.wallpaper}"; # TODO: This doesn't work rn because only PNG is supported..
          color = "rgb(${config.colorScheme.colors.base01})";

          # Blur
          blur_size = 8;
          blur_passes = 2;
          noise = 0.0117;
          contrast = 0.8917;
          brightness = 0.8172;
          vibrancy = 0.1686;
          vibrancy_darkness = 0.05;
        })
        config.myHomeManager.monitors;

      input-field = [
        {
          # monitor = "eDP-1";
          monitor = "${primaryMonitor}";
          size = "500, 50";
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgb(${config.colorScheme.colors.base01})";
          inner_color = "rgb(${config.colorScheme.colors.base02})";
          font_color = "rgb(${config.colorScheme.colors.base06})";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input password...</i>";
          # hide_input = true;
          hide_input = false;
          rounding = -1;
          check_color = "rgb(${config.colorScheme.colors.base0B})";
          fail_color = "rgb(${config.colorScheme.colors.base08})";
          fail_text = "<i>$FAIL</i>";
          fail_transition = 300;
          position = "0, -20";
          halign = "center";
          valign = "center";
          capslock_color = "rgb(${config.colorScheme.colors.base0E})";
          numlock_color = "-1";
          bothlock_color = "-1";
          invert_numlock = false;
        }
      ];

      label = [
        {
          monitor = "${primaryMonitor}";
          text = "Hi there, $USER";
          color = "rgb(${config.colorScheme.colors.base06})";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
