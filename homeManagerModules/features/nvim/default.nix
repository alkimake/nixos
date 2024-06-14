{pkgs, inputs, ...}: {
   imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
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
      flavour = "mocha";
      integrations = {
        cmp = true;
        gitsigns = true;
        notify = false;
        nvimtree = true;
        treesitter = true;
      };
    };

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };
}

