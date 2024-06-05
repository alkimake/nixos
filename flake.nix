{
  description = "Ake's multi device nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    hyprland.url = "github:hyprwm/Hyprland";

  };

  outputs = {...} @ inputs: let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #
        X1 = mkSystem ./hosts/X1/configuration.nix;
      };

      homeConfigurations = {
        "ake@X1" = mkHome "x86_64-linux" ./hosts/X1/home.nix;
      };

      nixosModules.default = ./nixosModules;

    };
}
