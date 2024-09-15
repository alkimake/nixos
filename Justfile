# Common Nix command with experimental features and no dirty warning
nix_flags := "--experimental-features 'nix-command flakes' --no-warn-dirty"
nix_cmd := "nix " + nix_flags

# List all available systems
list-systems:
    {{nix_cmd}} flake show

# Build a specific system
build system:
    @echo "Building system: {{system}}"
    {{nix_cmd}} build .#darwinConfigurations.{{system}}.config.system.build.toplevel

# Switch to a specific system
switch system:
    sudo nixos-rebuild switch --flake .#{{system}}

# Switch to a specific system
darwin switch system:
    sudo darwin-rebuild switch --flake .#{{system}}

# Update all inputs
update:
    {{nix_cmd}} flake update

# Update a specific input
update-input input:
    {{nix_cmd}} flake lock --update-input {{input}}

# Clean up old generations
clean:
    sudo nix-collect-garbage -d

# Show the diff between current and new generations
diff system:
    {{nix_cmd}} build .#nixosConfigurations.{{system}}.config.system.build.toplevel --no-link --print-out-paths | xargs -I {} nvd diff /run/current-system {}

