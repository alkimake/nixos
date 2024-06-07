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

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };
}

