{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myHomeManager;

  pimg = pkgs.writeShellScriptBin "pimg" ''
    output="out.png"
    [ ! -z "$1" ] && output="$1.png"
    # xclip -se c -t image/png -o > "$output"
    ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
  '';

in {
  home.file = {
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -a --group-directories-first";
      l = "${pkgs.eza}/bin/eza -lbF --git --group-directories-first --icons";
      ll = "${pkgs.eza}/bin/eza -lbGF --git --group-directories-first --icons";
      llm =
        "${pkgs.eza}/bin/eza -lbGd --git --sort=modified --group-directories-first --icons";
      la =
        "${pkgs.eza}/bin/eza -lbhHigmuSa --time-style=long-iso --git --color-scale --group-directories-first --icons";
      lx =
        "${pkgs.eza}/bin/eza -lbhHigmuSa@ --time-style=long-iso --git --color-scale --group-directories-first --icons";
      lt =
        "${pkgs.eza}/bin/eza --tree --level=2 --group-directories-first --icons";
      tree = "${pkgs.eza}/bin/eza --color=auto --tree";
      cal = "cal -m";
      grep = "grep --color=auto";
      q = "exit";
      ":q" = "exit";
      weather = "${pkgs.curl}/bin/curl -4 http://wttr.in/Seoul";

    };
  };
  programs.zsh.initExtra = ''
    # EXTRACT FUNCTION (needs more nix)

    # PROMPT
    autoload -U colors && colors
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#${config.colorScheme.colors.base03}"
    bindkey '^ ' autosuggest-accept

  '';

  programs.zsh.envExtra = ''
    export EDITOR="nvim"
    export TERMINAL="kitty"
    export TERM="kitty"
    export BROWSER="firefox"
    export VIDEO="mpv"
    export IMAGE="imv"
    export OPENER="xdg-open"
    export SCRIPTS="$HOME/scripts"
    export LAUNCHER="rofi -dmenu"
    export FZF_DEFAULT_OPTS="--color=16"

    # Less colors
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
    export vimcolorscheme="gruvbox"

    # direnv
    export DIRENV_LOG_FORMAT=""
  '';

  home.packages = [
    pimg

  ];
}

