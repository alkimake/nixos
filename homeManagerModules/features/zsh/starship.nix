{...}: {
  # TODO: fix the coloring match with nix-colors
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    format = "$cmd_duration$hostname$localip$shlvl$shell$env_var$directory$character";
    right_format = "$direnv$singularity$kubernetes$vcsh$fossil_branch$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$crystal$custom$jobs$status$os$container$battery$time";
    direnv = {
      format = "[$symbol $loaded$allowed]($style)";
      disabled = false;
      symbol = "🌲";
      allowed_msg = "";
      loaded_msg = "";
    };
  };
}
