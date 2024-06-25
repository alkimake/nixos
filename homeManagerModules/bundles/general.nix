{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  myHomeManager.zsh.enable = lib.mkDefault true;
  myHomeManager.lf.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nil
    nixd
    file
    git
    p7zip
    unzip
    zip
    stow
    libqalculate
    imagemagick
    killall
    tmux

    fzf
    htop
    lf
    eza
    fd
    zoxide
    bat
    du-dust
    ripgrep
    neofetch
    lazygit

    wget

    tree-sitter

    nh
    nix-output-monitor
    nvd
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixos";
  };

  myHomeManager.impermanence.directories = [
    ".local/share/nvim"
    ".config/nvim"

    ".ssh"
  ];

  myHomeManager.impermanence.files = [
    ".zsh_history"
  ];
}
