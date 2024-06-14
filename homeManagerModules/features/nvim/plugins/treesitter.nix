{ lib, ... }:
{
  opts = {
    # Enable treesitter syntax highlighting
    enable = true;

    # Enable treesitter based indentation (use '=' to auto-indent)
    indent = true;

    # Workaround to enable incremental selection without setting default keymaps (keymaps are set globally)
    # This is needed in order to set custom descriptions and avoid to have multiple keymaps
    # See https://github.com/nix-community/nixvim/issues/1506
    moduleConfig.incremental_selection = {
      enable = true;
      keymaps = lib.mkForce { };
    };
  };
}
