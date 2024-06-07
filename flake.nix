{
  description = "Ake's multi device nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    prism = {
      url = "github:IogaMaster/prism";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/Hyprland";
    nixvim = {
        url = "github:nix-community/nixvim";
        # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        inputs.nixpkgs.follows = "nixpkgs";
    };
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
     
     homeManagerModules.default = ./homeManagerModules;
     nixosModules.default = ./nixosModules;

    };
}
