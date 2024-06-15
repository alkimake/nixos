{pkgs, helpers, ...}: {
   imports = [
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

 programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    luaLoader.enable = true;

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          cmp = true;
          gitsigns = true;
          notify = true;
          native_lsp = {
            enable = true;
            background = true;
          };
          neotree = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    extraPackages = with pkgs; [
      wl-clipboard

      # LSP requirements
      go
    ];
  };
}
