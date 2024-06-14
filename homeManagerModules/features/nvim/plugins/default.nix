{ lib, ... }@args:

let
  # Flag to enable LSP plugin with servers
  # Given as an extra special arg when building nixvim module
  withLSP = args.withLSP or true;

  # Load plugins filenames in list
  definitions = lib.attrNames (
    lib.filterAttrs
      (filename: kind:
        filename != "default.nix"
        && (kind == "regular" || kind == "directory")
        # If file is an LSP plugin, respect withLSP flag
        && (if filename == "lsp.nix" then withLSP else true)
      )
      (builtins.readDir ./.)
  );
in
lib.mkMerge (
  map
    (file:
    let
      pluginName = lib.elemAt (lib.splitString "." file) 0;
      plugin = import ./${file} args;
    in
    lib.mkMerge [
      (lib.optionalAttrs (plugin ? opts) {
        programs.nixvim.plugins.${pluginName} = plugin.opts;
      })
      (lib.optionalAttrs (plugin ? extra) {
        programs.nixvim.extraConfigLua = plugin.extra.config or "";
        programs.nixvim.extraPlugins = plugin.extra.packages;
      })
      (lib.optionalAttrs (plugin ? rootOpts) { 
        programs.nixvim = plugin.rootOpts or { };
      })
    ]
    )
    definitions
)
