{pkgs, ...}: let
  # FIXME: update the plugins
  tmux-nvim =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux.nvim";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "aserowy";
        repo = "tmux.nvim/";
        rev = "57220071739c723c3a318e9d529d3e5045f503b8";
        sha256 = "sha256-zpg7XJky7PRa5sC7sPRsU2ZOjj0wcepITLAelPjEkSI=";
      };
    };
in {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      tmux-nvim
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.yank
      tmuxPlugins.sensible
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
        '';
      }
    ];
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g status-position top
      set-option -sg escape-time 10
      bind -n S-down new-window
      bind -n S-left prev
      bind -n S-right next

      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Easier reload of config
      bind r source-file ~/.config/tmux/tmux.conf


      # Change splits to match nvim and easier to remember
      # Open new split at cwd of current split
      unbind %
      unbind '"'
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Use vim keybindings in copy mode
      set-window-option -g mode-keys vi

      # v in copy mode starts making selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel


      # make Prefix p paste the buffer.
      unbind p
      bind p paste-buffer


    '';
  };
}
