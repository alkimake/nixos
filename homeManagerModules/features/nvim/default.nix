{pkgs, inputs, ...}: {
   imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
          notify = false;
          neotree = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
