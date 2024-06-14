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

    extraPackages = with pkgs; [
      wl-clipboard
    ];

    autoGroups = {
      neotree = { };
    };

    autoCmd =
      let
        refresh = ''
          function()
            local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
            if manager_avail then
              for _, source in ipairs { "filesystem", "git_status", "document_symbols" } do
                local module = "neo-tree.sources." .. source
                if package.loaded[module] then manager.refresh(require(module).name) end
              end
            end
          end
        '';
      in
      [
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L21-L37
        {
          desc = "Open explorer on startup with directory";
          event = "BufEnter";
          group = "neotree";

          callback.__raw = ''
            function()
              if package.loaded["neo-tree"] then
                return true
              else
                local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
                if stats and stats.type == "directory" then
                  return true
                end
              end
            end
          '';
        }
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L25-L35
        {
          desc = "Refresh explorer sources when closing lazygit";
          event = "TermClose";
          group = "neotree";
          pattern = "*lazygit*";
          callback.__raw = refresh;
        }
        {
          desc = "Refresh explorer sources on focus";
          event = "FocusGained";
          group = "neotree";
          callback.__raw = refresh;
        }
      ];
  };
}

