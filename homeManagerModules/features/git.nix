{inputs, ...}: {
  programs.git = {
    enable = true;
    userEmail = "alkimake@pm.me";
    userName = "Alkim Ake Gozen";
    lfs = {
      enable = true;
      skipSmudge = true;
    };
    delta = {
      # TODO: Cattpuccin theme
      enable = true;
    };
    extraConfig = {
      push = {autoSetupRemote = true;};
      color = {
        ui = "auto";
      };
      init.defaultBrach = "main";
      core = {
        editor = "nvim";
      };
    };
    aliases = {
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      permission-reset = "!git diff -p -R --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply";
      lg = "log --graph --pretty=format:'%C(auto)%h%d%C(reset) %s %C(green)(%cd) %C(blue)<%an> %C(reset)' --date=relative";
      lgd = "log --graph --pretty=format:'%C(auto)%h%d%C(reset) %s %C(green)(%cd) %C(blue)(%ad) <%an> %C(reset)' --date=relative";
      lga = "log --graph --all --pretty=format:'%C(auto)%h%d%C(reset) %s %C(green)(%cd) %C(blue)<%an> %C(reset)' --date=relative";
      lgad = "log --graph --all --pretty=format:'%C(auto)%h%d%C(reset) %s %C(green)(%cd) %C(blue)(%ad) <%an> %C(reset)' --date=relative";
    };
    ignores = [
      ".vscode/"
      ".idea/"
      "venv/"
      "env/"
      ".venv/"
      ".editorconfig"
      "*.ake"
      "__pycache__/"
      "*.iml"
      "*.ipr"
      "*.iws"
      "*.drawio.bkp"
      ".DS_Store"
      "*.kubeconfig"
    ];
  };
}
