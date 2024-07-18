{...}: {
  # TODO: fix the coloring match with nix-colors
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    preset = [
      "jetpack"
      "nerd-font-symbols"
    ];
  };
}
